class Search
  def self.call(query)
    Search.new.call query
  end

  def initialize
  end

  def call(query)
    select(query).map do |row|
      case row['type']
      when 'Podcast'
        Podcast.find(row['id'])
      when 'Episode'
        Episode.find(row['id'])
      end
    end
  end

  private

  def select(query)
    ApplicationRecord.connection.select_all <<-SQL
    (SELECT id, 'Podcast' AS type FROM podcasts WHERE title ILIKE '%#{query}%')
    UNION
    (SELECT id, 'Episode' AS type FROM episodes WHERE title ILIKE '%#{query}%')
    SQL
  end
end
