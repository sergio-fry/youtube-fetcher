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

  def new_youtube_videos
    @podcast.youtube_video_list.videos
  end
end
