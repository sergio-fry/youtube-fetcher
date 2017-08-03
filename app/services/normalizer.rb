class Normalizer
  def normalize(path)
    `mp3gain #{path}`

    path
  end
end
