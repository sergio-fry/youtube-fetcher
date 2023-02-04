class PlaylistsController < ChannelsController
  PODCAST_SOURCE_TYPE = 'playlist'.freeze

  def channel
    @channel ||= Playlist.new id: params[:id]
  end
end
