class AudioEpisode < Episode
  self.table_name = 'episodes'

  def mime_type
    'audio/mp4'
  end
end
