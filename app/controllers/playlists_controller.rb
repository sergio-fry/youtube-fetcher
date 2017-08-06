class PlaylistsController < ChannelsController
  PODCAST_SOURCE_TYPE = 'playlist'.freeze
  PODCAST_YT_KLASS = Yt::Playlist.freeze

  private

  class PlaylistItemWrapper
    attr_reader :id

    def initialize(item)
      @id = item.video_id

    end
  end

  def new_youtube_videos
    channel.playlist_items.where(order: 'date').take(10).reverse.map do |item|
      PlaylistItemWrapper.new item
    end
  end
end
