class UpdatePodcastJob < ApplicationJob
  queue_as :high_priority

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
    @podcast.video_required?
  end

  def new_youtube_videos
    @podcast.youtube_video_list.videos
  end
end
