require 'rails_helper'

RSpec.describe CleanupOutdatedJob, type: :job do
  let(:podcast) { FactoryGirl.create :podcast }
  let!(:episode) { FactoryGirl.create :audio_episode, podcast: podcast }

  let(:episode_exists) { described_class.new.perform(podcast); AudioEpisode.exists?(episode.id)}
  let(:episode_is_deleted) { !episode_exists }

  it { expect(episode_exists).to eq true }

  context 'when episode is outdated ' do
    before do
      episode.update_attribute :created_at, 1.year.ago
      10.times { FactoryGirl.create :episode, podcast: podcast }
    end
    it { expect(episode_is_deleted).to eq true }

    it 'should create an ArchivedEpisode' do
      expect do
        described_class.new.perform(podcast)
      end.to change { ArchivedEpisode.count }.by(1)
    end

    context 'when no other episodes' do
      before { Episode.where.not(id: episode.id).destroy_all }
      it { expect(episode_exists).to eq true }
    end
  end

  context 'when there are too many new episodes' do
    before do
      Episode.delete_all
      51.times { FactoryGirl.create :episode, podcast: podcast }
    end

    it 'should create an ArchivedEpisode' do
      expect do
        described_class.new.perform(podcast)
      end.to change { ArchivedEpisode.count }.by(1)
    end
  end
end
