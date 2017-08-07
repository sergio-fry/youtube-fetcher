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
end
