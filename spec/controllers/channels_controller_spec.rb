require 'rails_helper'

RSpec.describe ChannelsController, type: :controller do
  render_views

  def make_request
    VCR.use_cassette :fetch_channel do
      get :show, params: { id: 'UCX0nHcqZWDSsAPog-LXdP7A' }, format: :atom
    end
  end

  it 'should fetch channel' do
    make_request

    expect(response).to be_success

    data = Hash.from_xml response.body

    expect(data['feed']['entry'].size).to eq 10

    entry = data['feed']['entry'][0]
    expect(entry).to be_present

    audio = entry['link'].find { |l| l['rel'] == 'enclosure' }
    expect(audio).to be_present

    expect(audio['href']).to include 'mp3'
  end

  it { expect { make_request }.to change { Podcast.count }.by(1) }
end
