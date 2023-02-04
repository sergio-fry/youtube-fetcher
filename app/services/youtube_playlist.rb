require 'nokogiri'
require 'net/http'

require_relative 'youtube_video_list'

class YoutubePlaylist < YoutubeVideoList
  class PlaylistItemWrapper
    attr_reader :id, :title, :published_at

    def initialize(item)
      @id = item.id
      @title = item.title
      @published_at = nil
    end
  end

  def videos
    Nokogiri::XML(
      resp.body
    ).css('entry').to_a.take(10)
  end

  def exists?
    resp.code == '200'
  end

  def resp
    uri = URI("https://www.youtube.com/feeds/videos.xml?playlist_id=#{origin_id}")
    Net::HTTP.get_response(uri)
  end
end
