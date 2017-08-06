class Normalizer
  def normalize(path)
    `mp3gain -q #{path}`

    path
  end
end
