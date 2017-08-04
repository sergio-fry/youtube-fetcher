class ChannelsController
  class Video
    attr_accessor :id, :origin_id, :published_at, :title, :description, :audio_url, :audio_size

    def self.build(episode)
      raise 'only AudioEpisode supported as initizlizer' unless episode.is_a? AudioEpisode

      video = new

      video.id = episode.id
      video.origin_id = episode.origin_id
      video.published_at = episode.published_at
      video.title = episode.title
      video.description = episode.description

      video.audio_url = episode.url
      video.audio_size = episode.size

      video
    end
  end
end
