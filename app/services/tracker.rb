class Tracker
  include Singleton

  attr_reader :staccato

  def initialize
    @staccato = Staccato.tracker(Rails.configuration.x.google_analytics_id, nil, ssl: true)
  end

  def self.event(*args)
    instance.staccato.event *args
  end
end
