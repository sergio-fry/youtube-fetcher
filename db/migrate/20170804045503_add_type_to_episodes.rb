class AddTypeToEpisodes < ActiveRecord::Migration[5.1]
  def change
    add_column :episodes, :type, :string, default: 'AudioEpisode', null: false
  end
end
