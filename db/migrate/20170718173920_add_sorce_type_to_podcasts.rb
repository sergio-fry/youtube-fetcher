class AddSorceTypeToPodcasts < ActiveRecord::Migration[5.1]
  def change
    add_column :podcasts, :source_type, :string
  end
end
