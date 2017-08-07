class CreateUserAgents < ActiveRecord::Migration[5.1]
  def change
    create_table :user_agents do |t|
      t.datetime :last_pageview_at

      t.timestamps
    end
  end
end
