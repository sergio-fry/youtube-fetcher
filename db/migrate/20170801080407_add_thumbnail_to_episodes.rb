class AddThumbnailToEpisodes < ActiveRecord::Migration[5.1]
  def change
    add_column :episodes, :thumbnail, :string
  end
end
