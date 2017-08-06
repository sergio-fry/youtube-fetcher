class PlaylistsController < ChannelsController
  PODCAST_SOURCE_TYPE = 'playlist'.freeze
  PODCAST_YT_KLASS = Yt::Playlist.freeze
end
