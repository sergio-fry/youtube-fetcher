class AddOriginIdToEpisodes < ActiveRecord::Migration[5.1]
  def change
    add_column :episodes, :origin_id, :string
  end
end
