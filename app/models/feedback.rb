class Feedback < ApplicationRecord
  validates :email, :title, :category, presence: true
end
