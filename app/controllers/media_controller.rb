class MediaController < ApplicationController
  private

  def fetch_audio(id)
    `youtube-dl --extract-audio --audio-format mp3 --audio-quality 7 https://www.youtube.com/watch?v=#{id}`
  end
end
