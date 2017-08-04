atom_feed do |feed|
  feed.title @channel.title

  feed.updated @videos.first.published_at if @videos.present?

  @videos.each do |video|
    feed.entry video, url: "https://www.youtube.com/watch?v=#{video.origin_id}" do |entry|
      entry.author do |author|
        author.name @channel.title
      end
      entry.updated video.published_at.rfc3339
      entry.title video.title
      entry.content video.description, type: 'html'

      entry.link rel: 'enclosure', type: 'audio/mpeg', title: 'audio', href: video.audio_url, length: video.audio_size

      if video.has_video?
        entry.link rel: 'enclosure', type: 'video/mp4', title: 'video', href: video.video_url, length: video.video_size
      end
    end
  end
end
