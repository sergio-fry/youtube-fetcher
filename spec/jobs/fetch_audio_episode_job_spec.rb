require 'rails_helper'

RSpec.describe FetchAudioEpisodeJob, type: :job do
  include MediaFilesHelper

  def perform_job
    VCR.use_cassette :fetch_video do
      job.perform(podcast, youtube_video_id)
    end
  end

  let(:job) { FetchAudioEpisodeJob.new }
  let(:podcast) { FactoryGirl.create :podcast, updated_at: 1.day.ago}
  let(:youtube_video_id) { 'fdpdN6K6ntY' }
  let(:temp_audio_file_path) { audio_file_example_path }

  before do
    allow(Tracker).to receive(:event)
    allow_any_instance_of(YoutubeDl).to receive(:fetch_audio) { temp_audio_file_path }
    Rails.cache.clear
    allow(UserAgentsPool).to receive(:has_free_users?) { true }
  end

  it 'should save media' do
    expect do
      perform_job
    end.to change { podcast.episodes.count }.by(1)
  end

  it 'should remove temp file' do
    perform_job
    expect(File.exists?(temp_audio_file_path)).to eq false
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
    its(:description) { is_expected.to match(/Дети, а теперь я вам расскажу о/) }
    its(:published_at) { is_expected.to be_a Time }
    its(:origin_id) { is_expected.to eq youtube_video_id }
    its(:size) { is_expected.to eq 160749 }
    its(:media_size) { is_expected.to eq 160749 }
  end

  context 'when no free users' do
    include ActiveJob::TestHelper

    before do
      allow(Tracker).to receive(:event)
      allow(UserAgentsPool).to receive(:has_free_users?) { false }
    end

    it 'should reschedule job' do
      assert_enqueued_with(job: described_class) do
        perform_job
      end
    end
  end

  context 'when live stream is not finished' do
    # To update this VCR cassete you must pick another live video from Youtube
    let(:youtube_video_id) { 'UCtaBak-I3w' }

    it 'should fail' do
      VCR.use_cassette :fetch_live_video do
        expect do
          job.perform(podcast, youtube_video_id)
        end.to raise_error(FetchAudioEpisodeJob::LiveStreamIsNotFinished)
      end
    end
  end
end
