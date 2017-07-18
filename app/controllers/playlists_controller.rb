class PlaylistsController < ChannelsController
  def show
    @podcast = Podcast.find_or_create_by origin_id: params[:id], source_type: 'playlist'
    @channel = Yt::Playlist.new id: params[:id]

    @videos = @podcast.episodes.order('published_at DESC').limit(10)

    schedule_episodes_fetching
  end

  private

  def schedule_episodes_fetching
    return if @podcast.updated_at > 10.minutes.ago && @podcast.updated_at > @podcast.created_at
    @channel.playlist_items.where(order: 'date').take(10).reverse.each do |item|
      FetchEpisodeJob.perform_later @podcast, item.video_id
    end
  end
end
