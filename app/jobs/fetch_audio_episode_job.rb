class FetchAudioEpisodeJob < ApplicationJob
  queue_as :default

  EPISODES_RELATION = 'episodes'.freeze

  class Fetcher
    def fetch(id)
      path = fetch_media id

      Tracker.event category: :audio, action: :download, label: id

      path
    rescue YoutubeDl::UnknownError => ex
      Tracker.event category: 'Error', action: ex.class, label: ex.message
      raise ex # raise again
    end

    private

    def fetch_media(id)
      YoutubeDl.new.fetch_audio id
    end
  end

  def perform(podcast, youtube_video_id, fetcher=Fetcher.new)
    return if podcast.send(self.class::EPISODES_RELATION).exists?(origin_id: youtube_video_id)

    @youtube_video_id = youtube_video_id
    podcast.send(self.class::EPISODES_RELATION).create(
      origin_id: youtube_video_id,
      media: File.open(fetcher.fetch(youtube_video_id)),
      title: video.title,
      published_at: video.published_at
    )
  end

  private

  def video
    @video ||= Yt::Video.new id: @youtube_video_id
  end
end
