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
    podcast.episodes.create(media: File.open(fetcher.fetch_audio(youtube_video_id)))
  end
end
