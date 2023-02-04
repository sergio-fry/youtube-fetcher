module Youtube
  class Feed
    def initialize(url)
      @url = url
    end

    def videos
      doc.css('entry').to_a
    end

    def title
      doc.css('title')[0].text
    end

    def resp
      uri = URI(@url)
      Net::HTTP.get_response(uri)
    end

    def doc
      @doc ||= Nokogiri::XML(resp.body)
    end
  end
end
