class CreateUserAgents < ActiveRecord::Migration[5.1]
  def change
    create_table :user_agents do |t|
      t.datetime :last_pageview_at
      t.string :user_agent
      t.text :cookies

      t.timestamps
    end
  end
end
