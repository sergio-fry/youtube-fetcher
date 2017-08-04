class YoutubeDl
  class UnknownError < StandardError; end;
  class IncompleteYoutubeId < UnknownError; end;

  def fetch_audio(id)
    exec "--extract-audio --audio-format mp3 --audio-quality 9 -o '#{Rails.root.join('tmp', 'youtube', '%(id)s.%(ext)s')}' https://www.youtube.com/watch?v=#{id}"

    normalizer.normalize Rails.root.join('tmp', 'youtube', "#{id}.mp3")
  end

  def fetch_video(id)
    exec "-f 'worst[height>=360]+worstaudio' --recode-video mp4 -o '#{Rails.root.join('tmp', 'youtube-videos', '%(id)s.%(ext)s')}' https://www.youtube.com/watch?v=#{id}"
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
