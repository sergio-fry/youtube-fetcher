class PlaylistsController < ChannelsController
  def show
    @podcast = Podcast.find_or_create_by origin_id: params[:id], source_type: 'playlist'
    @channel = Yt::Playlist.new id: params[:id]

    @videos = @podcast.episodes.order('published_at DESC').limit(10)

    schedule_episodes_fetching
  end

  private

  class PlaylistItemWrapper
    attr_reader :id

    def initialize(item)
      @id = item.video_id
    end
  end

  def new_youtube_videos
    @channel.playlist_items.where(order: 'date').take(10).reverse.map do |item|
      PlaylistItemWrapper.new item
    end
  end
end
