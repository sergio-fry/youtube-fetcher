require 'rails_helper'

RSpec.describe PlaylistsController, type: :controller do
  render_views

  def make_request
    VCR.use_cassette :fetch_playlist do
      get :show, params: { id: youtube_playlist_id }, format: :atom
    end
  end

  let(:youtube_playlist_id) { 'PLOGi5-fAu8bH_T9HhH9V2B5izEE4G5waV' }

  let(:podcast) { FactoryGirl.create :podcast, :playlist, origin_id: youtube_playlist_id }
  before do
    20.times do
      FactoryGirl.create :episode, podcast: podcast
    end
  end

  it 'should fetch playlist' do
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

  context 'when playlist is new' do
    before { Podcast.destroy_all }
    it { expect { make_request }.to change { Podcast.count }.by(1) }
  end
end
