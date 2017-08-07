require 'rails_helper'

RSpec.describe YoutubeDl do
  let(:youtube_dl) { YoutubeDl.new }

  before do
    allow(youtube_dl).to receive(:exec)
    allow_any_instance_of(Normalizer).to receive(:normalize)
  end

  describe '#fetch_audio' do
    it 'should work' do
      youtube_dl.fetch_audio 'ABC123'
    end
  end

  describe '#fetch_video' do
    it 'should work' do
      youtube_dl.fetch_video 'ABC123'
    end
  end

  describe '#error_handler' do
    context do
      let(:response) do
        <<-TEXT
ERROR: Incomplete YouTube ID ABC123. URL https://www.youtube.com/watch?v=ABC123 looks truncated.
        TEXT
      end

      it 'should raise error' do
        expect do
          youtube_dl.send(:error_handler, response)
        end.to raise_error YoutubeDl::IncompleteYoutubeId
      end
    end
  end

  describe '.with_user_agent' do
    let!(:user_agent) { FactoryGirl.create :user_agent }

    it 'should get free user' do
      YoutubeDl.with_user_agent do |ua|
        expect(ua).to eq user_agent
      end
    end

    context 'when user_agent is used recently' do
      before { user_agent.update_attribute :last_pageview_at, 5.seconds.ago }

      it 'should get free user' do
        expect do
          YoutubeDl.with_user_agent do |ua|
          end
        end.to raise_error(YoutubeDl::NoFreeUsersLeft)
      end
    end
  end
end


