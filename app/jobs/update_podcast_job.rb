class UpdatePodcastJob < ApplicationJob
  queue_as :high_priority

  def perform(podcast)
    @podcast = podcast

    MarkPodcastAsRemovedJob.perform_later podcast

    return if podcast.deleted?

    new_youtube_videos.each do |video|
      add_pending_episode video.id
      FetchAudioEpisodeJob.perform_later(@podcast, video.id) if audo_required?
      if Flipper.enabled?(:video)
        FetchVideoEpisodeJob.perform_later(@podcast, video.id) if video_required?
      end
    end

  ensure
    @podcast.touch :fetched_at
  end

  private

  def add_pending_episode(origin_id)
    if audo_required? && !AudioEpisode.exists?(origin_id: origin_id)
      PendingEpisode.find_or_create_by origin_id: origin_id, episode_type: 'audio' do |pe|
        pe.updated_at = Time.now
      end
    end

    if Flipper.enabled?(:video) && video_required? && !VideoEpisode.exists?(origin_id: origin_id)
      PendingEpisode.find_or_create_by origin_id: origin_id, episode_type: 'video' do |pe|
        pe.updated_at = Time.now
      end
    end
  end

  def audo_required?
    @podcast.audo_required?
  end

  def video_required?
    @podcast.video_required?
  end

  def new_youtube_videos
    @podcast.youtube_video_list.videos
  end
end
