class YoutubeDl
  class UnknownError < StandardError; end
  class IncompleteYoutubeId < UnknownError; end

  def fetch_audio(id)
    exec "--extract-audio --audio-format mp3 --audio-quality 9 -o '#{Rails.root.join('tmp', 'youtube', '%(id)s.%(ext)s')}' https://www.youtube.com/watch?v=#{id}"

    Rails.root.join('tmp', 'youtube', "#{id}.mp3")
  end

  private

  def error_handler(response)
    return unless response.match?(/ERROR/)

    error = response.match(/ERROR: (.+)/)[1]

    if response.match?(/ERROR: Incomplete YouTube ID/)
      raise IncompleteYoutubeId, error
    else
      raise UnknownError, error
    end
  end

  def exec(options)
    Rails.logger.info "youtube-dl #{options}"
    error_handler `youtube-dl #{options}`
  end
end
