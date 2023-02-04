require 'nokogiri'
require 'open-uri'
require_relative 'youtube_video_list'
require_relative 'youtube/feed'

class YoutubeChannel
  attr_reader :id

  def initialize(id)
    @id = id
  end

  def videos
    feed.videos.take(10)
  end

  def title
    feed.title
  end

  def feed
    Youtube::Feed.new("https://www.youtube.com/feeds/videos.xml?channel_id=#{@id}")
  end
end
