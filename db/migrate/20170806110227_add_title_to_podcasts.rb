class AddTitleToPodcasts < ActiveRecord::Migration[5.1]
  def change
    add_column :podcasts, :title, :string
  end
end
