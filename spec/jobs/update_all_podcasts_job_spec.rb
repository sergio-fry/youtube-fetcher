require 'rails_helper'

RSpec.describe UpdateAllPodcastsJob, type: :job do
  let!(:podcast) { FactoryGirl.create :podcast, fetched_at: 2.hours.ago }

  it 'should work' do
    UpdateAllPodcastsJob.new.perform
  end

  it 'should update podcast' do
    expect(UpdatePodcastJob).to receive(:perform_later).with(podcast)
    UpdateAllPodcastsJob.new.perform
  end

  context 'when podcast has not been accessed more than a day' do
    before { podcast.update_attribute :accessed_at, 2.days.ago }

    it 'should not update podcast' do
      expect(UpdatePodcastJob).not_to receive(:perform_later).with(podcast)
      UpdateAllPodcastsJob.new.perform
    end
  end
  
  context 'when podcast has not been accessed less than a day' do
    before { podcast.update accessed_at: 12.hours.ago, fetched_at: 2.hours.ago }

    it 'should not update podcast' do
      expect(UpdatePodcastJob).to receive(:perform_later).with(podcast)
      UpdateAllPodcastsJob.new.perform
    end
  end

  context 'when podcast is updated more often than published' do
    before do
      podcast.update fetched_at: 30.minutes.ago
      allow_any_instance_of(Podcast).to receive(:episodes_per_hour) { 0.1 }
    end

    it 'should not update podcast' do
      expect(UpdatePodcastJob).not_to receive(:perform_later).with(podcast)
      UpdateAllPodcastsJob.new.perform
    end
  end

  context 'when podcast is updated less often than published' do
    before do
      podcast.update fetched_at: 30.minutes.ago
      allow_any_instance_of(Podcast).to receive(:episodes_per_hour) { 3 }
    end

    it 'should update podcast' do
      expect(UpdatePodcastJob).to receive(:perform_later).with(podcast)
      UpdateAllPodcastsJob.new.perform
    end
  end

  context 'when podcast has not been updated more than hour' do
    before do
      podcast.update fetched_at: 2.hours.ago
      allow_any_instance_of(Podcast).to receive(:episodes_per_hour) { 0.01 }
    end

    it 'should update podcast' do
      expect(UpdatePodcastJob).to receive(:perform_later).with(podcast)
      UpdateAllPodcastsJob.new.perform
    end
  end
end
