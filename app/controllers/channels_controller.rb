class ChannelsController < ApplicationController
  def show
    Podcast.find_or_create_by origin_id: params[:id]
    @channel = Yt::Channel.new id: params[:id]
    @videos = @channel.videos.where(order: 'date').take(10)
  end
end
