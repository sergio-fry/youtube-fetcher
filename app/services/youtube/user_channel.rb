require_relative 'feed'

module Youtube
  class UserChannel
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
      Feed.new("https://www.youtube.com/feeds/videos.xml?user=#{@id}")
    end
  end
end
