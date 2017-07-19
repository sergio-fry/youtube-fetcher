require 'rails_helper'

RSpec.describe ChannelsController, type: :controller do
  render_views

  def make_request
    VCR.use_cassette :fetch_channel do
      get :show, params: { id: youtube_channel_id }, format: :atom
    end
  end

  let(:youtube_channel_id) { 'UCX0nHcqZWDSsAPog-LXdP7A' }

  let(:podcast) { FactoryGirl.create :podcast, origin_id: youtube_channel_id, updated_at: 1.day.ago }
  before do
    20.times do
      FactoryGirl.create :episode, podcast: podcast
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

  context 'when channel is new' do
    before { Podcast.destroy_all }
    it { expect { make_request }.to change { Podcast.count }.by(1) }
  end

  describe '.channel_id' do
    subject { controller.send(:channel_id) }
    before { allow(controller).to receive(:channel_url) { channel_url } }
    let(:channel_url) { 'https://www.youtube.com/channel/UCX0nHcqZWDSsAPog-LXdP7A' }

    it { is_expected.to eq 'UCX0nHcqZWDSsAPog-LXdP7A' }
  end

  describe '.playlist_id' do
    subject { controller.send(:playlist_id) }
    before { allow(controller).to receive(:channel_url) { channel_url } }
    let(:channel_url) { 'https://www.youtube.com/playlist?list=PLOGi5-fAu8bH_T9HhH9V2B5izEE4G5waV' }

    it { is_expected.to eq 'PLOGi5-fAu8bH_T9HhH9V2B5izEE4G5waV' }
  end
end
