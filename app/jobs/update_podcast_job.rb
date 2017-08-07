class UpdatePodcastJob < ApplicationJob
  queue_as :default

  def perform(podcast)
    @podcast = podcast

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
