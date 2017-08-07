require 'rails_helper'

RSpec.describe Podcast, type: :model do
  let(:podcast) { FactoryGirl.create :podcast }

  describe '#episodes_per_week' do
    subject { podcast.episodes_per_week }

    context 'when has no episodes' do
      it { is_expected.to eq 0 }
    end

    context do
      before do
        FactoryGirl.create :episode, podcast: podcast, published_at: 1.day.ago
      end

      it { is_expected.to eq 1 }
    end

    context do
      before do
        FactoryGirl.create :episode, podcast: podcast, published_at: 2.days.ago
        FactoryGirl.create :episode, podcast: podcast, published_at: 1.day.ago
      end

      it { is_expected.to eq 2 }
    end
  end

  describe '#episodes_per_hour' do
    it 'should be (24 * 7) time less than episodes_per_week' do
      allow(podcast).to receive(:episodes_per_week) { 24 * 7 }
      expect(podcast.episodes_per_hour).to eq 1
    end
  end
end
