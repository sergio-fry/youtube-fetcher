class UpdateStatsJob < ApplicationJob
  queue_as :high_priority

  KEEP_PENDINGS_PERIOD = 1.day

  def perform
    t = Time.now

    SimpleMetric::Metric.add_data_point StatsController::PODCASTS_KEY, t, Podcast.count
    SimpleMetric::Metric.add_data_point StatsController::VIDEO_EPISODES_KEY, t, VideoEpisode.count
    SimpleMetric::Metric.add_data_point StatsController::AUDIO_EPISODES_KEY, t, AudioEpisode.count

    update_pendings t
  end

  private

  def update_pendings(t)
    PendingEpisode.where('updated_at < ?', KEEP_PENDINGS_PERIOD.ago).delete_all
    SimpleMetric::Metric.add_data_point StatsController::PENDING_AUDIO_EPISODES_KEY, t, PendingEpisode.where(episode_type: 'audio').count
    SimpleMetric::Metric.add_data_point StatsController::PENDING_VIDEO_EPISODES_KEY, t, PendingEpisode.where(episode_type: 'video').count
  end
end
