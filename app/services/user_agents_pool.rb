class UserAgentsPool
  class NoFreeUsersLeft < StandardError; end;

  IDLE_PERIOD = ENV.fetch('USER_AGENT_IDLE_PERIOD', '30').to_i.seconds

  # Get exclusive lock for a free user
  #
  # UserAgentsService.with_user_agent do |ua|
  #   # do something with user_agent here
  # end
  def self.with_user_agent
    raise NoFreeUsersLeft unless has_free_users?

    user_agent = free_users.first

    user_agent.update_attributes last_pageview_at: Time.now
    result = yield user_agent

    if File.exist? user_agent.cookies_jar.path
      user_agent.update_attributes cookies: File.read(user_agent.cookies_jar.path)
    end

    result
  end

  def self.has_free_users?
    free_users.exists?
  end

  def self.generate
    UserAgent.create! user_agent: UserAgentRandomizer::UserAgent.fetch.string
  end

  def self.clear
    UserAgent.destroy_all
  end

  def self.size
    UserAgent.count
  end

  def self.free_users
    UserAgent.where('last_pageview_at IS NULL OR last_pageview_at < ?', IDLE_PERIOD.ago).
      order('last_pageview_at')
  end
end

