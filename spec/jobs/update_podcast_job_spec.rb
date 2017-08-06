require 'rails_helper'

RSpec.describe UpdatePodcastJob, type: :job do
  let(:podcast) { FactoryGirl.create :podcast, origin_id: 'UCX0nHcqZWDSsAPog-LXdP7A' }

  it 'should work' do
    VCR.use_cassette :fetch_channel do
      UpdatePodcastJob.new.perform(podcast)
    end
  end

  it 'should update updated_at field' do
    VCR.use_cassette :fetch_channel do
      expect do
        UpdatePodcastJob.new.perform(podcast)
      end.to change { podcast.reload.updated_at }
    end
  end

  context 'when playlist' do
    let(:podcast) { FactoryGirl.create :podcast, source_type: :playlist, origin_id: 'PLOGi5-fAu8bH_T9HhH9V2B5izEE4G5waV' }

    it 'should work' do
      VCR.use_cassette :fetch_playlist do
        UpdatePodcastJob.new.perform(podcast)
      end
    end
  end
end
