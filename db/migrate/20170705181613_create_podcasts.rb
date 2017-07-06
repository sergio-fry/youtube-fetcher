class CreatePodcasts < ActiveRecord::Migration[5.1]
  def change
    create_table :podcasts do |t|
      t.string :origin_id, null: false

      t.timestamps
    end

    add_index :podcasts, :origin_id, unique: true
  end
end
