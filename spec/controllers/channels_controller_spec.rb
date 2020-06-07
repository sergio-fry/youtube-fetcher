require 'rails_helper'

RSpec.describe ChannelsController, type: :controller do

  describe 'GET /show' do
    render_views

    def make_request(format=:atom, type=nil)
      VCR.use_cassette :fetch_channel do
        get :show, params: { id: youtube_channel_id, type: type }, format: format
      end
    end

    let(:youtube_channel_id) { 'UCX0nHcqZWDSsAPog-LXdP7A' }

    let(:podcast) { FactoryGirl.create :podcast, origin_id: youtube_channel_id, updated_at: 1.day.ago }
    let!(:episode) { FactoryGirl.create :episode, podcast: podcast }
    let!(:video_episode) { FactoryGirl.create :video_episode, podcast: podcast, origin_id: episode.origin_id }

    describe 'accessed_at' do
      it 'should update accessed_at when atom requested' do
        expect do
          make_request :atom
        end.to change{ podcast.reload.accessed_at }
      end

      it 'should NOT update accessed_at when html requestes' do
        expect do
          make_request :html
        end.not_to change{ podcast.reload.accessed_at }
      end
    end

    context 'when no video requested' do
      it 'should not update video_requested_at' do
        expect do
          make_request
        end.not_to change{ podcast.reload.video_requested_at }
      end
    end

    context 'when video requested' do
      it 'should update video_requested_at' do
        expect do
          make_request(:atom, :video)
        end.to change{ podcast.reload.video_requested_at }
      end
    end

    xit 'should fetch channel' do
      make_request

      expect(response).to be_success

      data = Hash.from_xml response.body

      entry = data['feed']['entry']
      expect(entry).to be_present

      audio = entry['link'].find { |l| l['rel'] == 'enclosure' && l['type'] == 'audio/mpeg' }
      expect(audio).to be_present
      expect(audio['href']).to include 'mp3'
    end

    it 'should fetch video channel' do
      make_request :atom, :video

      expect(response).to be_success

      data = Hash.from_xml response.body

      entry = data['feed']['entry']
      expect(entry).to be_present


      video = entry['link'].find { |l| l['rel'] == 'enclosure' && l['type'] == 'video/mp4' }
      expect(video).to be_present
      expect(video['href']).to include 'mp4'
    end

    it 'should render channel as HTNL' do
      make_request :html
      expect(response).to be_success
    end
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

  describe 'POST /create' do
    def make_request
      VCR.use_cassette cassette do
        post :create, params: { channels_controller_channel: { url: youtube_url } }
      end
    end

    context 'when channel' do
      let(:cassette) { :fetch_channel }
      let(:youtube_url) { 'https://www.youtube.com/channel/UCX0nHcqZWDSsAPog-LXdP7A' }
      it { expect { make_request }.to change { Podcast.count }.by(1) }

      context 'when channel is already exists but with another title' do
        before do
          make_request
          podcast = Podcast.find_by origin_id: 'UCX0nHcqZWDSsAPog-LXdP7A'
          podcast.update_attribute :title, 'Foo bar'
        end

        it { expect { make_request }.not_to change { Podcast.count } }
      end
    end

    context 'when playlist' do
      let(:cassette) { :fetch_playlist }
      let(:youtube_url) { 'https://www.youtube.com/playlist?list=PLOGi5-fAu8bH_T9HhH9V2B5izEE4G5waV' }
      it { expect { make_request }.to change { Podcast.count }.by(1) }
    end
  end

  describe 'GET /index' do
    render_views
    it 'should work' do
      get :index
    end
  end
end
