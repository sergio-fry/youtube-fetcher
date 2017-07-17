class FetchEpisodeJob < ApplicationJob
  queue_as :default

  class Fetcher
    def fetch_audio(id)
      Tracker.timing(category: 'runtime', variable: 'youtube-dl', label: 'download') do
        YoutubeDl.new.fetch_audio id
      end

      Tracker.event category: :audio, action: :download, label: youtube_video_id
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
