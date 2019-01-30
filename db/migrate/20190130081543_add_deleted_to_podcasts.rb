class AddDeletedToPodcasts < ActiveRecord::Migration[5.1]
  def change
    add_column :podcasts, :deleted, :boolean, default: false, null: false
  end
end
