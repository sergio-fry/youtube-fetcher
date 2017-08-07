class UpdateAllPodcastsJob < ApplicationJob
  queue_as :default

  def perform
    Podcast.find_each { |p| UpdatePodcastJob.perform_later(p) }
  end
end
