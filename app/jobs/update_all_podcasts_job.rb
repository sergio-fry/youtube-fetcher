class UpdateAllPodcastsJob < ApplicationJob
  queue_as :high_priority

  def perform
    Podcast.find_each do |podcast|
      next unless is_popular?(podcast)
      next if is_fresh_enough?(podcast)
      UpdatePodcastJob.perform_later(podcast)
    end
  end

  private

  def is_popular?(podcast)
    podcast.accessed_at > 1.day.ago
  end

  def is_fresh_enough?(podcast)
    !new_episode_is_predicted?(podcast) && has_been_updated_less_than_hour_ago?(podcast)
  end

  def new_episode_is_predicted?(podcast)
    (podcast.fetched_at < episodes_period(podcast).ago)
  end

  def has_been_updated_less_than_hour_ago?(podcast)
    (podcast.fetched_at > 1.hour.ago)
  end

  def episodes_period(podcast)
    1.hour / [podcast.episodes_per_hour, 1].max
  end
end
