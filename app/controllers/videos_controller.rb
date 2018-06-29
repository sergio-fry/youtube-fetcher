class VideosController < ApplicationController
  def show
    @video = Video.new params[:id]

    respond_to do |format|
      format.html
      if Flipper.enabled? :video
        format.mp4 do
          redirect_to video_url(@video.origin_id)
        end
      end
    end
  end

  def index
    @videos = VideosRepository.new.page(params[:page]).per(10)
  end

  private

  def video_url(id)
    Rails.cache.fetch("VideosController#video_url##{id}", expires_in: 1.hour) do
      YoutubeDl.new.fetch_video_url(id)
    end
  end
end
