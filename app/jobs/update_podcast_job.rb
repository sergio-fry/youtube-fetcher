class UpdatePodcastJob < ApplicationJob
  queue_as :default

  def perform(podcast)
    @podcast = podcast

    return if @podcast.updated_at > 10.minutes.ago && @podcast.updated_at > @podcast.created_at
    new_youtube_videos.each do |video|
      FetchAudioEpisodeJob.perform_later @podcast, video.id
      FetchVideoEpisodeJob.perform_later @podcast, video.id
    end

    @podcast.touch
  end

  private

  class PlaylistItemWrapper
    attr_reader :id

    def initialize(item)
      @id = item.video_id
    end
  end

  def new_youtube_videos
    case @podcast.source_type
    when 'playlist'
      Yt::Playlist.new(id: @podcast.origin_id).playlist_items.where(order: 'date').take(10).reverse.map do |item|
        PlaylistItemWrapper.new item
      end
    else
      Yt::Channel.new(id: @podcast.origin_id).videos.where(order: 'date').take(10).reverse
    end
  end
end
