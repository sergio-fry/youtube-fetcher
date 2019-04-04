require 'rails_helper'

RSpec.feature "Feedbacks", type: :feature do
  scenario "user fills in feedback form and see Thank You text" do
    visit "/"
    click_on "Leave Feedback"

    fill_in 'Title', with: 'Nice site'
    fill_in 'Email', with: 'my@email.com'
    click_on 'Send Feedback'

    expect(page).to have_content "Thank You!"
  end
end
