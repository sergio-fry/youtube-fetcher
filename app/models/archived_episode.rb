class ArchivedEpisode < Episode
  self.table_name = 'episodes'

  def mime_type
    'none'
  end
end
