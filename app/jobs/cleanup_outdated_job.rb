class CleanupOutdatedJob < ApplicationJob
  queue_as :high_priority

  PERIOD_TO_KEEP = 1.week
  MIN_EPISODES_TO_STORE = 10
  MAX_EPISODES_TO_STORE = ENV.fetch('MAX_EPISODES_TO_STORE', 50)

  def perform
    Podcast.find_each do |podcast|
      cleanup_episodes_scope podcast.audio_episodes
      cleanup_episodes_scope podcast.video_episodes
    end
  end

  private

  def cleanup_episodes_scope(scope)
    old_episodes(scope).find_each { |episode| archive_episode episode }
    episodes_exceeded_limit(scope).find_each { |episode| archive_episode episode }
  end

  def old_episodes(scope)
    scope.where.not(id: cant_be_deleted(scope)).where('created_at < ?', PERIOD_TO_KEEP.ago)
  end

  def episodes_exceeded_limit(scope)
    scope.where.not(id: episodes_allowed_to_keep(scope))
  end

  def episodes_allowed_to_keep(scope)
    scope.order(:created_at).limit(MAX_EPISODES_TO_STORE)
  end

  def cant_be_deleted(scope)
    scope.recent.limit(MIN_EPISODES_TO_STORE).pluck(:id)
  end

  def archive_episode(episode)
    Episode.transaction do
      ArchivedEpisode.create! episode.attributes.symbolize_keys.except(:id, :type, :media, :media_size)
      episode.destroy
    end
  end
end
