
# 404 playlist PLKxLRVPSSlq_vwA7WLgNjw30ZZiDRdVK2
RSpec.describe YoutubePlaylist do
  describe '.videos' do
  let(:youtube_playlist_id) { 'PLOGi5-fAu8bH_T9HhH9V2B5izEE4G5waV' }

    it 'should give a list of videos' do
      VCR.use_cassette :fetch_playlist_list do
        channel = YoutubePlaylist.new youtube_playlist_id
        expect(channel).to be_exists
        expect(channel.videos).to be_a(Array)
        expect(channel.videos.size).to eq 10
      end
    end

    context 'channel not found' do
      # Not found
      let(:youtube_channel_id) { 'PLKxLRVPSSlq_vwA7WLgNjw30ZZiDRdVK2' }

      it 'should should raise error' do
        VCR.use_cassette :fetch_playlist_list_404 do
          channel = YoutubePlaylist.new youtube_channel_id
          expect(channel).not_to be_exists
        end
      end
    end
  end
end

