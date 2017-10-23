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
    yt_list.playlist_items.take(100).reverse[0..10].map(&:video).map do |v|
      begin
        PlaylistItemWrapper.new(v)
      rescue
      end
    end.compact
  end

  private

  def yt_list
    Yt::Playlist.new(id: origin_id)
  end
end
