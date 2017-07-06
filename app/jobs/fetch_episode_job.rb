class FetchEpisodeJob < ApplicationJob
  queue_as :default

  class Fetcher
    def fetch_audio(id)
      cmd = "youtube-dl --extract-audio --audio-format mp3 --audio-quality 9 -o '#{Rails.root.join('tmp', 'youtube', '%(id)s.%(ext)s')}' https://www.youtube.com/watch?v=#{id}"
      Rails.logger.info cmd
      `#{cmd}`
      Rails.root.join('tmp', 'youtube', "#{id}.mp3")
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
