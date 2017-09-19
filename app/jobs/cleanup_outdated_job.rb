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

    scope.where.not(id: cant_be_deleted).where('created_at < ?', PERIOD_TO_KEEP.ago).find_each do |episode|
      archive_episode episode
    end
  end

  def archive_episode(episode)
    Episode.transaction do
      ArchivedEpisode.create! episode.attributes.symbolize_keys.except(:id, :type, :media, :media_size)
      episode.destroy
    end
  end
end
