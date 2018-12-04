class AddOriginIdIndexToEpisodes < ActiveRecord::Migration[5.1]
  def self.up
    add_index :episodes, :origin_id
  end

  def self.down
    remove_index :episodes, :origin_id
  end
end
