class AddAccessedAtToPodcasts < ActiveRecord::Migration[5.1]
  def up
    add_column :podcasts, :accessed_at, :datetime
    Podcast.update_all accessed_at: Time.now
  end

  def down
    remove_column :podcasts, :accessed_at
  end
end
