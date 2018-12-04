require 'rails_helper'

RSpec.describe VideosRepository do
  describe '#page' do
    subject { described_class.new.page(page) }
    let(:page) { 1 }
    let!(:episode) { FactoryGirl.create :episode }

    it { is_expected.to be_present }

    context 'when video episode exist' do
      before { FactoryGirl.create :video_episode, origin_id: episode.origin_id }
      its(:count) { is_expected.to eq 1 }
    end

    context 'when video is disabled' do
      before { Flipper.disable(:video) }
      its(:count) { is_expected.to eq 1 }
    end
  end
end
