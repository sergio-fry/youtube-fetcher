class UpdateStatsJob < ApplicationJob
  queue_as :high_priority

  def perform
    t = Time.now

    SimpleMetric::Metric.add_data_point StatsController::PODCASTS_KEY, t, Podcast.count
    SimpleMetric::Metric.add_data_point StatsController::VIDEO_EPISODES_KEY, t, VideoEpisode.count
    SimpleMetric::Metric.add_data_point StatsController::AUDIO_EPISODES_KEY, t, AudioEpisode.count
    SimpleMetric::Metric.add_data_point StatsController::PENDING_AUDIO_EPISODES_KEY, t, PendingEpisode.where(episode_type: 'audio').count
    SimpleMetric::Metric.add_data_point StatsController::PENDING_VIDEO_EPISODES_KEY, t, PendingEpisode.where(episode_type: 'video').count
  end
end
