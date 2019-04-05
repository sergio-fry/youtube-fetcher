class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  rescue_from ActiveRecord::RecordNotFound do
    render plain: 'Not found', status: 404
  end

  helper_method :stats

  before_action :set_locale

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
    when :video_count
      AudioEpisode.count
    else
      nil
    end
  end

  def set_locale
    accept_locales = browser.accept_language.map(&:code).map(&:to_sym)
    preferred_locale = (accept_locales & Rails.configuration.i18n.available_locales).first
    I18n.locale = preferred_locale || I18n.default_locale
  end
end
