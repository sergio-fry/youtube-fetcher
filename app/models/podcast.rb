class Podcast < ApplicationRecord
  validates :origin_id, presence: true
  has_many :episodes, dependent: :destroy, class_name: 'AudioEpisode'
  has_many :video_episodes, dependent: :destroy, class_name: 'VideoEpisode'
end
