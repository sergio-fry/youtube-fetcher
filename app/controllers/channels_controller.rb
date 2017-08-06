class ChannelsController < ApplicationController
  PODCAST_SOURCE_TYPE = nil.freeze
  PODCAST_YT_KLASS = Yt::Channel.freeze

  class Channel < Podcast
    attr_accessor :url
  end

  def create
    if playlist_id.present?
      redirect_to playlist_path(playlist_id)
    else
      redirect_to channel_path(channel_id)
    end
  end

  def show
    @podcast = Podcast.find_or_create_by origin_id: params[:id], source_type: self.class::PODCAST_SOURCE_TYPE
    @channel = self::class::PODCAST_YT_KLASS.new id: params[:id]

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
    return if @podcast.updated_at > 10.minutes.ago && @podcast.updated_at > @podcast.created_at
    new_youtube_videos.each do |video|
      FetchAudioEpisodeJob.perform_later @podcast, video.id
      FetchVideoEpisodeJob.perform_later @podcast, video.id
    end

    @podcast.touch
  end

  def new_youtube_videos
    @channel.videos.where(order: 'date').take(10).reverse
  end
end
