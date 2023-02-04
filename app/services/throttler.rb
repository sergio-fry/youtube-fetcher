# Throttler.throttle "Update feeds", 1.minute do
#   ...
# end
class Throttler
  def initialize(period, name, cache: Rails.cache)
    @period = period
    @name = name
    @cache = cache
  end

  def action(&block)
    return if ever? && last_action_at > @period.ago

    execute_and_track(block)
  end

  def self.throttle(name, period, &block)
    new(period, name).action(&block)
  end

  private
  
  def execute_and_track(block)
    track!
    block.call
  end

  def track!
    @cache.write key, Time.now.to_i, expires_in: @period
  end

  def ever?
    @cache.exist?(key)
  end

  def last_action_at
    return unless @cache.exist?(key)

    Time.at @cache.read(key)
  end

  def key
    "Throttler:#{@name}"
  end
end
