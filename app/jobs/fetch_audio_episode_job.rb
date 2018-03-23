class FetchAudioEpisodeJob < ApplicationJob
  queue_as :default

  EPISODES_RELATION = 'episodes'.freeze
  EVENT_CATEGORY = 'audio'.freeze

  # Do not try to fetche the same episode more often then THROTTLE_PERIOD
  THROTTLE_PERIOD = 1.hour.freeze

  class LiveStreamIsNotFinished < StandardError; end;

  attr_reader :local_media_path, :youtube_video_id

  class Fetcher
    def fetch(id)
      fetch_media id
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
    @fetcher = fetcher

    if UserAgentsPool.has_free_users?
      Throttler.throttle "#{self.class} #{youtube_video_id}", THROTTLE_PERIOD do

        # We should ignore not finished videos because downloading takes too long
        raise LiveStreamIsNotFinished.new('Live stream is not finished yet') if is_video_on_air?

        fetch_and_save_episode(podcast)

        cleanup
      end
    else
      self.class.set(wait_untill: UserAgentsPool::IDLE_PERIOD.from_now).perform_later(podcast, youtube_video_id)
    end
  end

  private

  def cleanup
    `rm #{local_media_path}`
  end

  def fetch_and_save_episode(podcast)
    t0 = Time.now

    fetch_media

    raise "No media file downloaded: #{podcast.inspect}, #{youtube_video_id}" unless File.exists?(local_media_path)

    episode = podcast.send(self.class::EPISODES_RELATION).create!(
      origin_id: @youtube_video_id,
      media: File.open(local_media_path),
      media_size: File.size(local_media_path),
      title: video.title,
      description: video.description,
      published_at: video.published_at
    )
    t = Time.now - t0

    track_event episode, t
    remove_pending_episode

    episode
  end

  def remove_pending_episode
    PendingEpisode.where(origin_id: @youtube_video_id, episode_type: 'audio').destroy_all
  end

  def is_video_on_air?
    video.live_broadcast_content != 'none' && video.actual_end_time.nil?
  end

  def track_event(episode, time)
    Tracker.event category: self.class::EVENT_CATEGORY, action: :fetch, label: "'#{episode.title}' #{episode.origin_id} in #{time.round(2)}s"
  end

  def fetch_media
    return if @fetcher.nil?
    @local_media_path ||= @fetcher.fetch(@youtube_video_id)
  end

  def video
    @video ||= Yt::Video.new id: @youtube_video_id
  end
end
