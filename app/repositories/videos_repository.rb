class VideosRepository
  SUBQUERY = <<-SQL
    SELECT DISTINCT ON (origin_id) * FROM episodes
  SQL

  def page(number)
    scope = Episode.select('*').from("(#{SUBQUERY}) AS videos").order('created_at DESC').page(number)

    def scope.count
      Rails.cache.fetch 'VideosRepository#page:count', expires_in: 10.minutes do
        Episode.connection.select_value "SELECT COUNT(*) FROM (#{SUBQUERY}) AS videos"
      end
    end

    scope
  end
end
