require 'rails_helper'

RSpec.describe FetchEpisodeJob, type: :job do
  def perform_job
    job.perform(podcast, youtube_video_id, fetcher)
  end

  let(:job) { FetchEpisodeJob.new }
  let(:podcast) { FactoryGirl.create :podcast }
  let(:youtube_video_id) { 'AAbbCC123' }
  let(:fetcher) { double(:fetcher, fetch_audio: Rails.root.join('spec', 'fixtures', 'audio.mp3'))}

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
      expect(subject.media.url).to include '.mp3'
    end
  end
end
