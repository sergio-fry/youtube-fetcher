class Podcast < ApplicationRecord
  validates :origin_id, presence: true
end
