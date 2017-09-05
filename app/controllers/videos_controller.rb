class VideosController < ApplicationController
  def show
    @video = Video.new params[:id]
  end
end
