atom_feed do |feed|
  feed.title("My great blog!")
  feed.updated(@feedbacks[0].created_at) if @feedbacks.length > 0

  @feedbacks.each do |feedback|
    feed.entry(feedback) do |entry|
      entry.title("#{feedback.title} - #{feedback.category}")
      entry.content(feedback.body, type: 'text')

      entry.author do |author|
        author.name(feedback.email)
      end
    end
  end
end
