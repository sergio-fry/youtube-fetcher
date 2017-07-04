class ChannelsController < ApplicationController
  def show
    @channel = Yt::Channel.new id: params[:id]

  end
end
