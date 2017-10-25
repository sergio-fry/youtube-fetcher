class ChannelsController < ApplicationController
  PODCAST_SOURCE_TYPE = nil.freeze
  PODCAST_YT_KLASS = Yt::Channel.freeze

  helper_method :new_videos

  class Channel < Podcast
    attr_accessor :url
  end

  def create
    if playlist_id.present?
      create_podcast playlist_id, 'playlist', Yt::Playlist.new(id: playlist_id).title
      redirect_to playlist_path(playlist_id)
    elsif channel_id.present?
      create_podcast channel_id, nil, Yt::Channel.new(id: channel_id).title
      redirect_to channel_path(channel_id)
    elsif channel_id_by_user_id.present?
      create_podcast channel_id_by_user_id, nil, Yt::Channel.new(id: channel_id_by_user_id).title
      redirect_to channel_path(channel_id_by_user_id)
    else
      redirect_to root_path
    end
  end

  def show
    @podcast = Podcast.find_by! origin_id: params[:id]
    @podcast.update_attributes accessed_at: Time.now
    @podcast.update_attributes(video_requested_at: Time.now) if type == 'video'

    @videos = if type == 'video'
                @podcast.video_episodes
              else
                @podcast.episodes
              end

    @videos = @videos.recent.limit(10)
    @videos = @videos.map { |v| Video.new v.origin_id, v }
  end

  def new
    @channel = Channel.new
  end

  def index
    @channels = Podcast.all
  end

  private

  def new_videos
    return [] if @podcast.created_at < 1.hour.ago
    attrs = Rails.cache.fetch "ChannelsController:#{@podcast.youtube_video_list.origin_id}:videos", expires_in: 15.minutes do
      @podcast.youtube_video_list.videos.map do |v|
        begin
        { origin_id: v.id, title: v.title, published_at: v.published_at }
        rescue
          nil
        end
      end.compact
    end

    attrs.map do |attr|
      Episode.new attr
    end.map { |v| Video.new v.origin_id, v }.reject do |e|
      Episode.exists?(origin_id: e.origin_id)
    end
  end

  def type
    params[:type] == 'video' ? 'video' : 'audio'
  end

  def create_podcast(origin_id, source_type, title)
    podcast = Podcast.find_or_initialize_by origin_id: origin_id
    podcast.update_attributes title: title, source_type: source_type, accessed_at: Time.now, video_requested_at: Time.now

    UpdatePodcastJob.set(queue: :high_priority).perform_later podcast

    podcast
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

  def user_id
    m = channel_url.match(/youtube.com\/user\/(.+)/)

    return if m.blank?

    m[1]
  end

  def channel_id_by_user_id
    @channel_id_by_user_id ||= begin
                                 url = "https://www.googleapis.com/youtube/v3/channels?key=#{ENV.fetch('YOUTUBE_API_KEY')}&forUsername=#{user_id}&part=id"
                                 data = JSON.parse open(url).read

                                 data['items'][0]['id']
                               end
  rescue
    nil
  end

  def channel_url
    params[:channels_controller_channel][:url]
  end
end
