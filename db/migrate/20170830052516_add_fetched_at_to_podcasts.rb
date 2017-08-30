class AddFetchedAtToPodcasts < ActiveRecord::Migration[5.1]
  def change
    add_column :podcasts, :fetched_at, :datetime
  end
end
