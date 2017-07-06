class Episode < ApplicationRecord
  belongs_to :podcast
  mount_uploader :media, MediaUploader

  validates :title, presence: true
  validates :published_at, presence: true
end
