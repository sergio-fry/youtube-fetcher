require 'rails_helper'

RSpec.describe Search do
  describe 'search results' do
    subject(:results) { Search.call query }

    context 'when search "mos"' do
      let(:query) { 'mos' }

      let!(:podcast_moscow) { FactoryGirl.create :podcast, title: 'Moscow' }
      let!(:podcast_london) { FactoryGirl.create :podcast, title: 'London' }

      it { is_expected.to include podcast_moscow }
      it { is_expected.not_to include podcast_london }

      let!(:episode_moscow_news) { FactoryGirl.create :episode, title: 'Moscow News' }
      let!(:episode_peter_news) { FactoryGirl.create :episode, title: 'Peter News' }
      it { is_expected.to include episode_moscow_news }
      it { is_expected.not_to include episode_peter_news }
    end
  end
end
