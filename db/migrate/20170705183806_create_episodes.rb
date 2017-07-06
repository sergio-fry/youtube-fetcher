class CreateEpisodes < ActiveRecord::Migration[5.1]
  def change
    create_table :episodes do |t|
      t.integer :podcast_id

      t.timestamps
    end

    add_foreign_key :episodes, :podcasts
  end
end
