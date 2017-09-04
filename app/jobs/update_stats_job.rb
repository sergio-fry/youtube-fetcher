class UpdateStatsJob < ApplicationJob
  queue_as :high_priority

  def perform
    t = Time.now

    SimpleMetric::Metric.add_data_point StatsController::PODCASTS_KEY, t, Podcast.count
    SimpleMetric::Metric.add_data_point StatsController::VIDEO_EPISODES_KEY, t, VideoEpisode.count
    SimpleMetric::Metric.add_data_point StatsController::AUDIO_EPISODES_KEY, t, AudioEpisode.count
  end
end
