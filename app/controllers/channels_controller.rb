class ChannelsController < ApplicationController

  class Channel < Podcast
    attr_accessor :url
  end

  def create
    return redirect_to(playlist_path(playlist_id)) if playlist_id.present?
    return redirect_to(channel_path(channel_id)) if channel_id.present?
    redirect_to :root
  end

  def show
    @channel = Yt::Channel.new id: params[:id]
    @channel.title # exception if wrong :id
    @podcast = Podcast.find_or_create_by origin_id: params[:id]
    @videos = @podcast.episodes.order('published_at DESC').limit(10)
    schedule_episodes_fetching
  rescue
    redirect_to :root
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
      FetchEpisodeJob.perform_later @podcast, video.id, video.snippet.data
    end
  end

  def new_youtube_videos
    @channel.videos.where(order: 'date').take(10).reverse
  end
end
