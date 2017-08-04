require 'rails_helper'

RSpec.describe FetchVideoEpisodeJob, type: :job do
  def perform_job
    VCR.use_cassette :fetch_video do
      job.perform(podcast, youtube_video_id)
    end
  end

  let(:job) { FetchVideoEpisodeJob.new }
  let(:podcast) { FactoryGirl.create :podcast, updated_at: 1.day.ago}
  let(:youtube_video_id) { 'fdpdN6K6ntY' }

  before do
    allow(Tracker).to receive(:event)
    allow_any_instance_of(YoutubeDl).to receive(:fetch_video) do
      Rails.root.join('spec', 'fixtures', 'video.mp4')
    end
  end

  it 'should save media' do
    expect do
      perform_job
    end.to change { podcast.episodes.count }.by(1)
  end

  describe 'new episode' do
    before { perform_job }
    subject { podcast.episodes.first }

    it { is_expected.to be_present }

    it 'should have media' do
      expect(subject.media).to be_present
      expect(subject.media.url).to include '.mp4'
    end

    its(:title) { is_expected.to eq 'Порошенко и дети' }
    its(:published_at) { is_expected.to be_a Time }
    its(:origin_id) { is_expected.to eq youtube_video_id }
    its(:size) { is_expected.to eq 996692 }
  end
end
