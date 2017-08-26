require 'rails_helper'

RSpec.describe CleanupOutdatedJob, type: :job do
  let(:podcast) { FactoryGirl.create :podcast }
  let!(:episode) { FactoryGirl.create :episode, podcast: podcast }

  let(:episode_exists) { described_class.new.perform; Episode.exists?(episode.id)}
  let(:episode_is_deleted) { !episode_exists }

  it { expect(episode_exists).to eq true }

  context 'when episode is outdated ' do
    before do
      episode.update_attribute :published_at, 1.year.ago
      10.times { FactoryGirl.create :episode, podcast: podcast }
    end
    it { expect(episode_is_deleted).to eq true }

    context 'when no other episodes' do
      before { Episode.where.not(id: episode.id).destroy_all }
      it { expect(episode_exists).to eq true }
    end
  end
end
