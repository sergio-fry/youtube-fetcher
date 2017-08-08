class UserAgentsService
  class NoFreeUsersLeft < StandardError; end;

  def self.with_user_agent
    user_agent = UserAgent.where(last_pageview_at: nil).first
    raise NoFreeUsersLeft if user_agent.blank?

    yield user_agent
  end
end
