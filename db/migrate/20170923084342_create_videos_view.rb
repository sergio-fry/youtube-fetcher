class CreateVideosView < ActiveRecord::Migration[5.1]
  def up
    execute <<-SQL
    CREATE VIEW videos AS
      SELECT DISTINCT ON (origin_id) * FROM episodes
    SQL
  end

  def down
    execute <<-SQL
    DROP VIEW videos
    SQL
  end
end
