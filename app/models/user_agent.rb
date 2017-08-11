class UserAgent < ApplicationRecord
  validates :user_agent, presence: true

  class CookieJar
    def initialize(user_agent)
      @user_agent = user_agent

      if @user_agent.cookies.present?
        File.open path, 'w' do |f|
          f.write @user_agent.cookies
        end
      end
    end

    def path
      FileUtils.mkdir_p Rails.root.join('tmp', 'cookies')
      Rails.root.join('tmp', 'cookies', "user_agent_#{@user_agent.id}.txt")
    end
  end

  def cookies_jar
    CookieJar.new(self)
  end
end
