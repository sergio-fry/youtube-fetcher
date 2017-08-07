require 'rails_helper'

RSpec.describe UpdateAllPodcastsJob, type: :job do
  let!(:podcast) { FactoryGirl.create :podcast }

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
end
