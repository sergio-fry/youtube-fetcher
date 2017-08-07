class FillPodcastsTitles < ActiveRecord::Migration[5.1]
  def up
    Podcast.find_each do |p|
      p.update_attribute(:title, (p.youtube_video_list.send(:yt_list).title rescue 'Unknown'))
    end
  end
end
