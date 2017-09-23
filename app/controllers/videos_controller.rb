class VideosController < ApplicationController
  def show
    @video = Video.new params[:id]
  end

  def index
    @videos = VideosRepository.new.page(params[:page]).per(10)
  end
end
