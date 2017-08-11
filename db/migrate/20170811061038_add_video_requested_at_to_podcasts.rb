class AddVideoRequestedAtToPodcasts < ActiveRecord::Migration[5.1]
  def change
    add_column :podcasts, :video_requested_at, :datetime
  end
end
