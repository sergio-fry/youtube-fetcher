class ChannelsController < ApplicationController
  PODCAST_SOURCE_TYPE = nil.freeze
  PODCAST_YT_KLASS = Yt::Channel.freeze

  class Channel < Podcast
    attr_accessor :url
  end

  class EpisodeWrapper
    attr_reader :origin_id
    delegate :id, :title, :published_at, :description, :mime_type, :url, :size, to: :episode
    delegate :url, :size, to: :audio_episode, allow_nil: true, prefix: :audio
    delegate :url, :size, to: :video_episode, allow_nil: true, prefix: :video

    def initialize(origin_id, episode=nil)
      @origin_id = origin_id
      @episode = episode
    end

    def has_audio?
      audio_episode.present?
    end

    def has_video?
      video_episode.present?
    end

    private

    def audio_episode
      AudioEpisode.find_by(origin_id: origin_id)
    end

    def video_episode
      VideoEpisode.find_by(origin_id: origin_id)
    end

    def episode
      @episode ||= Episode.find_by(origin_id: origin_id)
    end
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
    @podcast.update_attributes accessed_at: Time.now

    @videos = if type == 'video'
                @podcast.video_episodes
              else
                @podcast.episodes
              end

    @videos = @videos.order('published_at DESC').limit(10)
    @videos = @videos.map { |v| EpisodeWrapper.new v.origin_id, v }
    @new_videos = new_videos

  end

  def new
    @channel = Channel.new
  end

  private

  def new_videos
    attrs = Rails.cache.fetch 'ChannelsController:#{@podcast.youtube_video_list.origin_id}:videos', expires_in: 15.minutes do
      @podcast.youtube_video_list.videos.map do |v|
        { origin_id: v.id, title: v.title, published_at: v.published_at }
      end
    end

    attrs.map do |attr|
      Episode.new attr
    end.map { |v| EpisodeWrapper.new v.origin_id, v }.reject do |e|
      Episode.exists?(origin_id: e.origin_id)
    end
  end

  def type
    params[:type] == 'video' ? 'video' : 'audio'
  end

  def create_podcast(origin_id, source_type, title)
    podcast = Podcast.find_or_initialize_by origin_id: origin_id
    podcast.update_attributes title: title, source_type: source_type, accessed_at: Time.now

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

  def channel_url
    params[:channels_controller_channel][:url]
  end
end
