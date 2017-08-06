class VideoEpisode < Episode
  self.table_name = 'episodes'

  def mime_type
    'video/mp4'
  end
end
