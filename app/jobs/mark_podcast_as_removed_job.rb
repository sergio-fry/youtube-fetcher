class MarkPodcastAsRemovedJob < ApplicationJob
  queue_as :default

  def perform(podcast)
    unless podcast.youtube_video_list.exists?
      podcast.update_attribute :deleted, true
    end
  end
end
