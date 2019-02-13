class Search
  def self.call(query)
    Podcast.where('title ILIKE ?', "%#{query}%")
  end
end
