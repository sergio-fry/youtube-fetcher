class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  rescue_from ActiveRecord::RecordNotFound do
    render plain: 'Not found', status: 404
  end

  helper_method :stats

  private

  include ActionView::Helpers::NumberHelper
  def stats(key)
    case key.to_sym
    when :jobs
      Delayed::Job.count
    when :podcasts
      Podcast.count
    when :audo_count
      AudioEpisode.count
    when :audio_size
      number_to_human_size AudioEpisode.sum(:media_size)
    when :video_count
      AudioEpisode.count
    when :video_size
      number_to_human_size VideoEpisode.sum(:media_size)
    else
      nil
    end
  end
end
