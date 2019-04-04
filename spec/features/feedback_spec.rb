require 'rails_helper'

RSpec.feature "Feedbacks", type: :feature do
  scenario "user fills in feedback form and see Thank You text" do
    visit "/"
  end
end
