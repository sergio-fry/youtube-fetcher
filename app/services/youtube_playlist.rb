class YoutubePlaylist
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
    @feed ||= Youtube::Feed.new("https://www.youtube.com/feeds/videos.xml?playlist_id=#{@id}")
  end

  def exists?
    feed.resp.code == '200'
  end
end
