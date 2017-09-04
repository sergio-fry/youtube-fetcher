class CreatePendingEpisodes < ActiveRecord::Migration[5.1]
  def change
    create_table :pending_episodes do |t|
      t.string :origin_id
      t.string :episode_type

      t.timestamps
    end
  end
end
