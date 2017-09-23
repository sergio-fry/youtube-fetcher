require 'rails_helper'

RSpec.feature "VideosPaginations", type: :feature do
  scenario 'We can go through pages and see videos' do
    20.times do |n|
      Timecop.travel n.seconds.ago do
        FactoryGirl.create :episode
      end
    end

    visit '/'
    click_on 'Recent Episodes'

    expect(page).to have_content Episode.first.title
    expect(page).not_to have_content Episode.last.title
  end
end
