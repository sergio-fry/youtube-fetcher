class MediaController < ApplicationController
  def audio
    send_file fetch_audio(params[:id]), type: 'audio/mpeg'
  end

  private

  def fetch_audio(id)
    cmd = "youtube-dl --extract-audio --audio-format mp3 --audio-quality 7 -o '#{Rails.root.join('tmp', 'youtube', '%(id)s.%(ext)s')}' https://www.youtube.com/watch?v=#{id}"
    Rails.logger.info cmd
    `#{cmd}`
    Rails.root.join('tmp', 'youtube', "#{id}.mp3")
  end
end
