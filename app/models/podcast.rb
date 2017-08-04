class Podcast < ApplicationRecord
  validates :origin_id, presence: true
  has_many :episodes, dependent: :destroy, class_name: 'AudioEpisode'
end
