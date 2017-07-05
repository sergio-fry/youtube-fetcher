class ChannelsController < ApplicationController
  def show
    @channel = Yt::Channel.new id: params[:id]
    @videos = @channel.videos.where(order: 'date').take(10)
  end
end
