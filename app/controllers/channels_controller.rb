class ChannelsController < ApplicationController
  PODCAST_SOURCE_TYPE = nil.freeze
  PODCAST_YT_KLASS = Yt::Channel.freeze

  class Channel < Podcast
    attr_accessor :url
  end

  def create
    if playlist_id.present?
      create_podcast playlist_id, 'playlist', Yt::Playlist.new(id: playlist_id).title
      redirect_to playlist_path(playlist_id)
    else
      create_podcast channel_id, nil, Yt::Channel.new(id: channel_id).title
      redirect_to channel_path(channel_id)
    end
  end

  def show
    @podcast = Podcast.find_by! origin_id: params[:id]

    @videos = if params[:type] == 'video'
                @podcast.video_episodes
              else
                @podcast.episodes
              end

    @videos = @videos.order('published_at DESC').limit(10)

    schedule_episodes_fetching
  end

  def new
    @channel = Channel.new
  end

  private

  def create_podcast(origin_id, source_type, title)
    Podcast.find_or_create_by origin_id: origin_id, title: title, source_type: source_type
  end

  def channel
    @channel ||= self::class::PODCAST_YT_KLASS.new id: params[:id]
  end

  def playlist_id
    m = channel_url.match(/youtube.com\/playlist\?list=(.+)/)

    return if m.blank?

    m[1]
  end

  def channel_id
    channel_url.split('/channel/')[1]
  end

  def channel_url
    params[:channels_controller_channel][:url]
  end

  def schedule_episodes_fetching
    UpdatePodcastJob.perform_later @podcast
  end
end
