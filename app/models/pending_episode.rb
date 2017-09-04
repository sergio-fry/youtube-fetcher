class PendingEpisode < ApplicationRecord
  validates :origin_id, presence: true, uniqueness: { scope: :episode_type }
end
