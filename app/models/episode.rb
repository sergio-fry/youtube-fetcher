class Episode < ApplicationRecord
  belongs_to :podcast
  mount_uploader :media, MediaUploader

  validates :title, presence: true
  validates :published_at, presence: true
  scope :recent, -> { order('published_at DESC') }

  def size
    media_size || media.size
  end

  def url
    media.url
  end
end
