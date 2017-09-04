class CleanupOutdatedJob < ApplicationJob
  queue_as :high_priority

  PERIOD_TO_KEEP = 1.week

  def perform
    Podcast.find_each do |podcast|
      cleanup_episodes_scope podcast.audio_episodes
      cleanup_episodes_scope podcast.video_episodes
    end
  end

  private

  def cleanup_episodes_scope(scope)
    cant_be_deleted = scope.recent.limit(Podcast::MIN_EPISODES_TO_STORE).pluck(:id)

    scope.where.not(id: cant_be_deleted).where('created_at < ?', PERIOD_TO_KEEP.ago).destroy_all
  end
end
