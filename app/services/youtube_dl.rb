class YoutubeDl
  class UnknownError < StandardError; end;
  class IncompleteYoutubeId < UnknownError; end;

  MAX_FILE_SIZE = '1G'.freeze


  def fetch_audio(id)
    exec "--extract-audio --audio-format mp3 --audio-quality 9 --max-filesize #{MAX_FILE_SIZE} -o '#{Rails.root.join('tmp', 'youtube', 'audios', '%(id)s.%(ext)s')}' https://www.youtube.com/watch?v=#{id}"

    normalizer.normalize Rails.root.join('tmp', 'youtube', 'audios', "#{id}.mp3")
  end

  def fetch_video(id)
    raise 'Deprecated: use fetch_video_url'
  end

  MAX_RETRIES = 10.freeze

  def fetch_video_url(id)
    MAX_RETRIES.times do
      url = exec "-f 'best[ext=mp4][height<=480]/worst[ext=mp4]' --max-filesize #{MAX_FILE_SIZE} -g https://www.youtube.com/watch?v=#{id}"

      return url if url.present?
    end

    raise 'Failed to get Video URL'
  end

  private

  def normalizer
    Normalizer.new
  end

  def error_handler(response)
    return response unless response.match(/ERROR/)

    error = response.match(/ERROR: (.+)/)[1]

    if response.match(/ERROR: Incomplete YouTube ID/)
      raise IncompleteYoutubeId.new error
    else
      raise UnknownError.new error
    end
  end

  def exec(options)
    UserAgentsPool.with_user_agent do |ua|
      cmd = "youtube-dl --user-agent \"#{ua.user_agent}\" --cookies #{ua.cookies_jar.path} #{options}"
      Rails.logger.info cmd

      error_handler `#{cmd}`
    end
  end
end
