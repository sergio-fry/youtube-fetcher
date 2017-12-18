class VideoEpisode < Episode
  self.table_name = 'episodes'

  def mime_type
    'video/mp4'
  end

  def url
    raise 'Deprecated: Please use videos#show action insted'
  end
end
