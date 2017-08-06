class YoutubeChannel < YoutubeVideoList
  def videos
    yt_list.videos.where(order: 'date').take(10).reverse
  end

  private

  def yt_list
    Yt::Channel.new(id: origin_id)
  end
end
