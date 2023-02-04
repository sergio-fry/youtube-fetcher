require 'app/services/youtube/channel'

module Youtube
  RSpec.describe Channel do
    describe '.videos' do
      let(:youtube_channel_id) { 'UCX0nHcqZWDSsAPog-LXdP7A' }

      it 'should give a list of videos' do
        VCR.use_cassette :fetch_channel_list do
          channel = described_class.new youtube_channel_id
          expect(channel.videos).to be_a(Array)
          expect(channel.videos.size).to eq 10
        end
      end
    end
  end
end
