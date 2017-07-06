class MediaController < ApplicationController
  def audio
    send_file fetch_audio(params[:id]), type: 'audio/mpeg'
  end

  private

  def fetch_audio(id)
    Episode.find_by(origin_id: id).media.path
  end
end
