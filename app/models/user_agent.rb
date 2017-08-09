class UserAgent < ApplicationRecord
  validates :user_agent, presence: true
end
