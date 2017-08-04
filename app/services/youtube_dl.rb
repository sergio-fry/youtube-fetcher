class YoutubeDl
  class UnknownError < StandardError; end;
  class IncompleteYoutubeId < UnknownError; end;

  def fetch_audio(id)
    exec "--extract-audio --audio-format mp3 --audio-quality 9 -o '#{Rails.root.join('tmp', 'youtube', '%(id)s.%(ext)s')}' https://www.youtube.com/watch?v=#{id}"

    normalizer.normalize Rails.root.join('tmp', 'youtube', "#{id}.mp3")
  end

  def fetch_video(id)
    exec "-f 'worst[ext=mp4][height>=360]+worstaudio/worst[ext=mp4]+worstaudio' --recode-video mp4 -o '#{Rails.root.join('tmp', 'youtube-videos', '%(id)s.%(ext)s')}' https://www.youtube.com/watch?v=#{id}"

    Rails.root.join('tmp', 'youtube-videos', "#{id}.mp4")
  end

  private

  def normalizer
    Normalizer.new
  end

  def error_handler(response)
    return unless response.match(/ERROR/)

    error = response.match(/ERROR: (.+)/)[1]

    if response.match(/ERROR: Incomplete YouTube ID/)
      raise IncompleteYoutubeId.new error
    else
      raise UnknownError.new error
    end
  end

  def exec(options)
    Rails.logger.info "youtube-dl #{options}"
    error_handler `youtube-dl #{options}`
  end
end
