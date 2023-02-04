require 'app/services/youtube_channel'

# 404 playlist PLKxLRVPSSlq_vwA7WLgNjw30ZZiDRdVK2
RSpec.describe YoutubeChannel do
  describe '.videos' do
    let(:youtube_channel_id) { 'UCX0nHcqZWDSsAPog-LXdP7A' }

    it 'should give a list of videos' do
      VCR.use_cassette :fetch_channel_list do
        channel = YoutubeChannel.new youtube_channel_id
        expect(channel.videos).to be_a(Array)
        expect(channel.videos.size).to eq 10
      end
    end
  end
end

