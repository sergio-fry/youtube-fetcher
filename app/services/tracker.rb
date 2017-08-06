class Tracker
  include Singleton

  attr_reader :staccato

  def initialize
    @staccato = Staccato.tracker(Rails.configuration.x.google_analytics_id, nil, ssl: true)
  end

  def event(*args)
    staccato.event(*args)
    slack_notifier.try(:ping, hash_to_message(args[0]))
  end

  def self.event(*args)
    instance.event(*args)
  end

  private

  def hash_to_message(h)
    "#{h[:category].to_s.titleize} #{h[:action]} #{h[:label]} #{h[:value]}"
  end

  def slack_notifier
    return if Rails.configuration.x.slack_webhook_url.blank?
    @slack_notifier ||= Slack::Notifier.new(Rails.configuration.x.slack_webhook_url)
  end
end
