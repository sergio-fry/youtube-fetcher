class FetchVideoEpisodeJob < FetchAudioEpisodeJob
  EPISODES_RELATION = 'video_episodes'.freeze
  EVENT_CATEGORY = 'video'.freeze

  class Fetcher < FetchAudioEpisodeJob::Fetcher
    private

    def fetch_media(id)
      YoutubeDl.new.fetch_video_url id
    end
  end

  def perform(podcast, youtube_video_id, fetcher=Fetcher.new)
    super
  end

  private

  def remove_pending_episode
    PendingEpisode.where(origin_id: @youtube_video_id, episode_type: 'video').destroy_all
  end

  def fetch_and_save_episode(podcast)
    t0 = Time.now

    fetch_media

    raise "No media file fetched: #{podcast.inspect}, #{youtube_video_id}" if @media_url.blank?
    raise "Empty media fecthed: #{podcast.inspect}, #{youtube_video_id}" if media_size.zero?

    episode = podcast.send(self.class::EPISODES_RELATION).create!(
      origin_id: @youtube_video_id,
      media_size: media_size,
      title: video.title,
      published_at: video.published_at
    )
    t = Time.now - t0

    track_event episode, t
    remove_pending_episode

    episode
  end

  def media_size
    @media_size ||= fetch_media_size
  end

  def fetch_media_size
    uri = URI(@media_url)

    response = nil

    Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https') do |http|
      req = Net::HTTP::Head.new uri
      response = http.request req
    end

    response.content_length
  end

  def fetch_media
    return if @fetcher.nil?
    @media_url ||= @fetcher.fetch(@youtube_video_id)
  end

  def cleanup; end
end
