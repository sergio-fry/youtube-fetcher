class FetchAudioEpisodeJob < ApplicationJob
  queue_as :default

  EPISODES_RELATION = 'episodes'.freeze
  EVENT_CATEGORY = 'audio'.freeze

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

    t0 = Time.now
    episode = podcast.send(self.class::EPISODES_RELATION).create(
      origin_id: youtube_video_id,
      media: File.open(local_media_path),
      title: video.title,
      published_at: video.published_at
    )
    t = Time.now - t0

    `rm #{local_media_path}`

    track_event episode, t
  rescue UserAgentsPool::NoFreeUsersLeft
    self.class.set(wait_untill: UserAgentsPool::IDLE_PERIOD.from_now).perform_later(podcast, youtube_video_id)
  end

  private

  def track_event(episode, time)
    Tracker.event category: self.class::EVENT_CATEGORY, action: :fetch, label: "'#{episode.title}' #{episode.origin_id} in #{time.round(2)}s"
    Tracker.event category: self.class::EVENT_CATEGORY, action: :fetchTime, label: episode.origin_id, value: time.round
  end

  def local_media_path
    return if @fetcher.nil?
    @local_media_path ||= @fetcher.fetch(@youtube_video_id)
  end

  def video
    @video ||= Yt::Video.new id: @youtube_video_id
  end
end
