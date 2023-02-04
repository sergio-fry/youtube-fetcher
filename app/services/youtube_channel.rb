require 'nokogiri'
require 'open-uri'
require_relative 'youtube_video_list'

class YoutubeChannel < YoutubeVideoList
  def videos
    Nokogiri::XML(
      URI::open("https://www.youtube.com/feeds/videos.xml?channel_id=#{origin_id}"
          )
    ).css('entry').to_a.take(10)
  end
end
