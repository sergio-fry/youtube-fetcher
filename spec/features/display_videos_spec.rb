require 'rails_helper'

RSpec.feature "DisplayVideos", type: :feature do
  scenario 'Display existed video' do
    episode = FactoryGirl.create :episode, title: 'Video title'

    visit video_path(episode.origin_id)

    expect(page).to have_content 'Video title'

  end
end
