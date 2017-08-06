class YoutubePlaylist < YoutubeVideoList
  class PlaylistItemWrapper
    attr_reader :id

    def initialize(item)
      @id = item.video_id
    end
  end

  def videos
    yt_list.playlist_items.where(order: 'date').take(10).reverse.map do |item|
      PlaylistItemWrapper.new item
    end
  end

  private

  def yt_list
    Yt::Playlist.new(id: origin_id)
  end
end
