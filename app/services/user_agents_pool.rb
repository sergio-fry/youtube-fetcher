class UserAgentsPool
  class NoFreeUsersLeft < StandardError; end;

  IDLE_PERIOD = 30.seconds

  # Get exclusive lock for a free user
  #
  # UserAgentsService.with_user_agent do |ua|
  #   # do something with user_agent here
  # end
  def self.with_user_agent
    user_agent = UserAgent.where('last_pageview_at IS NULL OR last_pageview_at < ?', IDLE_PERIOD.ago).
      order('last_pageview_at').
      first

    raise NoFreeUsersLeft if user_agent.blank?

    user_agent.update_attributes last_pageview_at: Time.now
    yield user_agent
  end
end
