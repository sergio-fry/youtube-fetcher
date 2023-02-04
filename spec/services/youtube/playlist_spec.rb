require 'app/services/youtube/playlist'

module Youtube
  RSpec.describe Playlist do
    describe '.videos' do
      let(:youtube_playlist_id) { 'PLOGi5-fAu8bH_T9HhH9V2B5izEE4G5waV' }

      it 'should give a list of videos' do
        VCR.use_cassette :fetch_playlist_list do
          channel = described_class.new youtube_playlist_id
          expect(channel.videos).to be_a(Array)
          expect(channel.videos.size).to eq 10
        end
      end
    end
  end
end
