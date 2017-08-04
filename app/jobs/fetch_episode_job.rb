class FetchEpisodeJob < ApplicationJob
  queue_as :default

  class Fetcher
    def fetch_audio(id)
      path = nil

      Tracker.timing(category: 'runtime', variable: 'youtube-dl', label: 'download') do
        path = YoutubeDl.new.fetch_audio id
      end

      Tracker.event category: :audio, action: :download, label: id

      path
    rescue YoutubeDl::UnknownError => ex
      Tracker.event category: 'Error', action: ex.class, label: ex.message
      raise ex # raise again
    end
  end

  def perform(podcast, youtube_video_id, fetcher=Fetcher.new)
    return if podcast.episodes.exists?(origin_id: youtube_video_id)

    @youtube_video_id = youtube_video_id
    podcast.episodes.create(
      origin_id: youtube_video_id,
      media: File.open(fetcher.fetch_audio(youtube_video_id)),
      title: video.title,
      published_at: video.published_at
    )

    podcast.touch
  end

  private

  def video
    @video ||= Yt::Video.new id: @youtube_video_id
  end
end
