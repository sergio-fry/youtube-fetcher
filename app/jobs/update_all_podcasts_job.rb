class UpdateAllPodcastsJob < ApplicationJob
  queue_as :default

  def perform
    Podcast.find_each do |podcast|
      next unless is_popular?(podcast)
      UpdatePodcastJob.perform_later(podcast)
    end
  end

  private

  def is_popular?(podcast)
    podcast.accessed_at > 1.day.ago
  end
end
