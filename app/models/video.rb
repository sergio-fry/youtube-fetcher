class Video
  attr_reader :origin_id
  delegate :id, :title, :description, :mime_type, :url, :size, to: :episode
  delegate :url, :size, to: :audio_episode, allow_nil: true, prefix: :audio
  delegate :size, to: :video_episode, allow_nil: true, prefix: :video

  def initialize(origin_id, episode=nil)
    @origin_id = origin_id
    @episode = episode
  end

  def has_media?
    has_audio? || has_video?
  end

  def has_audio?
    audio_episode.present?
  end

  def has_video?
    video_episode.present?
  end

  def preview_image_url
    "https://img.youtube.com/vi/#{origin_id}/hqdefault.jpg"
  end

  def origin_url
    "https://www.youtube.com/watch?v=#{origin_id}"
  end

  def channel
    episode.podcast
  end

  def published_at
    episode.created_at || episode.published_at
  end

  private

  def audio_episode
    AudioEpisode.find_by(origin_id: origin_id)
  end

  def video_episode
    VideoEpisode.find_by(origin_id: origin_id)
  end

  def episode
    @episode ||= Episode.find_by(origin_id: origin_id)
  end

end
