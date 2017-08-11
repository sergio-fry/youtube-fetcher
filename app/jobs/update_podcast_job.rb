class UpdatePodcastJob < ApplicationJob
  queue_as :default

  FORGET_ABOUT_VIDEO_PERIOD = 3.days

  def perform(podcast)
    @podcast = podcast

    new_youtube_videos.each do |video|
      FetchAudioEpisodeJob.perform_later @podcast, video.id
      FetchVideoEpisodeJob.perform_later(@podcast, video.id) if video_required?
    end

    @podcast.touch
  end

  private

  def video_required?
    @podcast.video_requested_at > FORGET_ABOUT_VIDEO_PERIOD.ago
  end

  def new_youtube_videos
    @podcast.youtube_video_list.videos
  end
end
