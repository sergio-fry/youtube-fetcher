require 'rails_helper'

RSpec.feature "Add new channel", type: :feature do
  it 'should add new channel' do
    VCR.use_cassette :fetch_channel do
      visit new_channel_url

      fill_in 'Paste Youtube channel/playlist URL here', with: 'https://www.youtube.com/channel/UCX0nHcqZWDSsAPog-LXdP7A'

      click_on 'Convert to podcast'

      expect(find_link('Subscribe')[:href]).to include '/channels/UCX0nHcqZWDSsAPog-LXdP7A.atom'
    end
  end

  it 'should add new playlist' do
    VCR.use_cassette :fetch_playlist do
      visit new_channel_url

      fill_in 'Paste Youtube channel/playlist URL here', with: 'https://www.youtube.com/playlist?list=PLOGi5-fAu8bH_T9HhH9V2B5izEE4G5waV'

      click_on 'Convert to podcast'

      expect(find_link('Subscribe')[:href]).to include '/playlists/PLOGi5-fAu8bH_T9HhH9V2B5izEE4G5waV.atom'
    end
  end

  it 'should add new channel by user id' do
    VCR.use_cassette :fetch_user do
      visit new_channel_url

      fill_in 'Paste Youtube channel/playlist URL here', with: 'https://www.youtube.com/user/TheKiberpop'

      click_on 'Convert to podcast'

      expect(find_link('Subscribe')[:href]).to include '/channels/UCyt4Uriznp9Y6H0JkOZfcHA.atom'
    end
  end
end
