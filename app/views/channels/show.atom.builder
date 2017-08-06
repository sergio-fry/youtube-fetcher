atom_feed do |feed|
  feed.title @podcast.title

  feed.updated @videos.first.published_at if @videos.present?

  @videos.each do |video|
    feed.entry video, url: "https://www.youtube.com/watch?v=#{video.origin_id}" do |entry|
      entry.author do |author|
        author.name @podcast.title
      end
      entry.updated video.published_at.rfc3339
      entry.title video.title
      entry.content video.description, type: 'html'

      entry.link rel: 'enclosure', type: video.mime_type, title: video.title, href: video.url, length: video.size
    end
  end
end
