require 'rails_helper'

RSpec.describe UpdatePodcastJob, type: :job do
  let(:podcast) { FactoryGirl.create :podcast, origin_id: 'UCX0nHcqZWDSsAPog-LXdP7A' }

  it 'should work' do
    VCR.use_cassette :fetch_channel do
      UpdatePodcastJob.new.perform(podcast)
    end
  end

  it 'should update fetched_at field' do
    VCR.use_cassette :fetch_channel do
      expect do
        UpdatePodcastJob.new.perform(podcast)
      end.to change { podcast.reload.fetched_at }
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

  describe 'video fetching' do
    include ActiveJob::TestHelper

    around do |example|
      VCR.use_cassette :fetch_channel do
        example.run
      end
    end

    context 'when video has not been requested more than 3 days' do
      before { podcast.update_attributes video_requested_at: 4.days.ago }

      it 'should not enqueue video fetching' do
        assert_enqueued_jobs(0, only: FetchVideoEpisodeJob) do
          UpdatePodcastJob.new.perform(podcast)
        end
      end
    end

    context 'when video has been requested recently' do
      before { podcast.update_attributes video_requested_at: 2.hours.ago }

      it 'should enqueue video fetching' do
        assert_enqueued_jobs(10, only: FetchVideoEpisodeJob) do
          UpdatePodcastJob.new.perform(podcast)
        end
      end
    end
  end
end
