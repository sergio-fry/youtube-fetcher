class CreateFeedbacks < ActiveRecord::Migration[5.1]
  def change
    create_table :feedbacks do |t|
      t.string :email, null: false
      t.string :title, null: false
      t.string :category, null: false
      t.text :body

      t.timestamps
    end
  end
end
