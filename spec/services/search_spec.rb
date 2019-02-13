require 'rails_helper'

RSpec.describe Search do
  describe 'search results' do
    subject(:results) { Search.call(query).map(&:origin_id) }

    context 'when search "mos"' do
      let(:query) { 'mos' }

      let!(:podcast_moscow) { FactoryGirl.create :podcast, title: 'Moscow' }
      let!(:podcast_london) { FactoryGirl.create :podcast, title: 'London' }

      it { is_expected.to include podcast_moscow.origin_id }
      it { is_expected.not_to include podcast_london.origin_id }

      let!(:episode_moscow_news) { FactoryGirl.create :episode, title: 'Moscow News' }
      let!(:episode_peter_news) { FactoryGirl.create :episode, title: 'Peter News' }
      it { is_expected.to include episode_moscow_news.origin_id }
      it { is_expected.not_to include episode_peter_news.origin_id }

      context 'russian query' do
        let(:query) { 'плюш' }
        let!(:episode_plushki) { FactoryGirl.create :episode, title: 'Плюшки Ярослава Мудрого' }
        it { is_expected.to include episode_plushki.origin_id }
      end
    end
  end
end
