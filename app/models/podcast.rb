class Podcast < ApplicationRecord
  FORGET_ABOUT_VIDEO_PERIOD = 3.days

  validates :origin_id, :title, :accessed_at, presence: true
  has_many :episodes, dependent: :destroy, class_name: 'AudioEpisode'
  has_many :video_episodes, dependent: :destroy, class_name: 'VideoEpisode'

  def youtube_video_list
    case source_type
    when 'playlist'
      YoutubePlaylist.new(origin_id)
    else
      YoutubeChannel.new(origin_id)
    end
  end

  def video_required?
    (video_requested_at.nil? && created_at > FORGET_ABOUT_VIDEO_PERIOD.ago) ||
      (
        !(video_requested_at.nil? && created_at < FORGET_ABOUT_VIDEO_PERIOD.ago) &&
        video_requested_at > FORGET_ABOUT_VIDEO_PERIOD.ago
      )
  end

  def episodes_per_week
    episodes.where('published_at > ?', 1.week.ago).count.to_f
  end

  HOURS_IN_A_WEEK = (7 * 24).freeze
  def episodes_per_hour
    episodes_per_week / HOURS_IN_A_WEEK.to_f
  end
end
