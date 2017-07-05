class MediaController < ApplicationController
  def audio
    send_data fetch_audio(params[:id]), type: 'audio/mpeg'
  end

  private

  def fetch_audio(id)
    cmd = "youtube-dl --extract-audio --audio-format mp3 --audio-quality 7 -o '#{Rails.root.join('tmp', 'youtube', '%(id)s.%(ext)s')}' https://www.youtube.com/watch?v=#{id}"

    puts cmd
    `#{cmd}`
    Rails.root.join('tmp', 'youtube', id, '.mp3')
  end
end
