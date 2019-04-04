atom_feed do |feed|
  feed.title @podcast.title

  feed.updated @videos.first.published_at if @videos.present?

  @videos.each do |video|
    feed.entry video, url: video_url(video.origin_id, utm_medium: :feed, utm_source: @podcast.origin_id, utm_campaign: video.origin_id) do |entry|
      entry.author do |author|
        author.name @podcast.title
      end
      entry.updated video.published_at.rfc3339
      entry.title video.title
      entry.content simple_format(video.description), type: 'html'

      entry.link rel: 'enclosure', type: video.mime_type, title: video.title, href: video.url, length: video.size
      entry.link rel: 'enclosure', type: 'image/jpeg', title: t(:preview), href: video.preview_image_url
    end
  end
end
