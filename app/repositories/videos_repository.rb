class VideosRepository
  SUBQUERY = <<-SQL
    SELECT DISTINCT ON (origin_id) * FROM episodes
  SQL

  def page(number)
    scope = Episode.select('*').from("(#{SUBQUERY}) AS videos").order('created_at DESC').page(number)

    def scope.count
      Episode.connection.select_value "SELECT COUNT(*) FROM (#{SUBQUERY}) AS videos"
    end

    scope
  end
end
