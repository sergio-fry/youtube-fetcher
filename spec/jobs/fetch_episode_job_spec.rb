require 'rails_helper'

RSpec.describe FetchEpisodeJob, type: :job do
  def perform_job
    VCR.use_cassette :fetch_video do
      job.perform(podcast, youtube_video_id, fetcher)
    end
  end

  let(:job) { FetchEpisodeJob.new }
  let(:podcast) { FactoryGirl.create :podcast, updated_at: 1.day.ago}
  let(:youtube_video_id) { 'fdpdN6K6ntY' }
  let(:fetcher) { double(:fetcher, fetch_audio: Rails.root.join('spec', 'fixtures', 'audio.mp3'))}

  before do
    allow(Tracker).to receive(:event)
  end

  it 'should save media' do
    expect do
      perform_job
    end.to change { podcast.episodes.count }.by(1)
  end

  it 'should update updated_at field' do
    expect do
      perform_job
    end.to change { podcast.updated_at }
  end

  describe 'new episode' do
    before { perform_job }
    subject { podcast.episodes.first }

    it { is_expected.to be_present }

    it 'should have media' do
      expect(subject.media).to be_present
      expect(subject.media.url).to include '.mp3'
    end

    its(:title) { is_expected.to eq 'Порошенко и дети' }
    its(:published_at) { is_expected.to be_a Time }
    its(:origin_id) { is_expected.to eq youtube_video_id }
    its(:size) { is_expected.to eq 160749 }
  end
end
