class FetchVideoEpisodeJob < FetchAudioEpisodeJob
  EPISODES_RELATION = 'video_episodes'.freeze

  class Fetcher < FetchAudioEpisodeJob::Fetcher
    private

    def fetch_media(id)
      YoutubeDl.new.fetch_video id
    end
  end

  def perform(podcast, youtube_video_id, fetcher=Fetcher.new)
    super
  end
end
