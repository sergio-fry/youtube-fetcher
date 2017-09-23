class VideosRepository
  def page(number)
    scope = Episode.select('*').from('videos').page(number)

    def scope.count
      Episode.connection.select_value 'SELECT COUNT(*) FROM videos'
    end

    scope
  end
end
