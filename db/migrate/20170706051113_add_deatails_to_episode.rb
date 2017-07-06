class AddDeatailsToEpisode < ActiveRecord::Migration[5.1]
  def change
    add_column :episodes, :title, :string
    add_column :episodes, :media_size, :integer
    add_column :episodes, :description, :text
    add_column :episodes, :published_at, :datetime
  end
end
