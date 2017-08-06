class Podcast < ApplicationRecord
  validates :origin_id, :title, presence: true
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
end
