class VideosController < ApplicationController
  def show
    @video = Video.new params[:id]
  end

  def index
    @videos = Episode.group(:origin_id).page(params[:page]).per(10)
  end
end
