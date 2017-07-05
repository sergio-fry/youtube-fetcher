class Episode < ApplicationRecord
  belongs_to :podcast
  mount_uploader :media, MediaUploader
end
