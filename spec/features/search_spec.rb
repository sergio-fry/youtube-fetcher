require 'rails_helper'

RSpec.feature "Search", type: :feature do
  scenario 'Type query and sea results' do
    podcast = FactoryGirl.create :podcast, title: 'Peter Episode'
    episode = FactoryGirl.create :episode, title: 'Moscow Episode'

    visit '/'
    
    fill_in 'Search', with: 'Peter'
    click_on 'Submit'

    expect(page).to have_content 'Peter Episode'
  end
end
