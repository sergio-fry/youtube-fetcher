class VideosRepository
  SUBQUERY = <<-SQL
    SELECT DISTINCT ON (origin_id) * FROM episodes
  SQL

  def page(number)
    if Flipper.enabled?(:video)
      scope_all.page(number)
    else
      scope_audio.page(number)
    end
  end

  private

  def scope_audio
    AudioEpisode.order('created_at DESC')
  end

  def scope_all
    scope = Episode.select('*').from("(#{SUBQUERY}) AS videos").order('created_at DESC')

    def scope.count
      Rails.cache.fetch 'VideosRepository#page:count', expires_in: 10.minutes do
        Episode.connection.select_value "SELECT COUNT(*) FROM (#{SUBQUERY}) AS videos"
      end
    end

    scope
  end
end
