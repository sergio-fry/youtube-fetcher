require 'rails_helper'

RSpec.describe Search do
  let!(:podcast_moscow) { FactoryGirl.create :podcast, title: 'Moscow' }
  let!(:podcast_london) { FactoryGirl.create :podcast, title: 'London' }

  let!(:podcast_moscow) { FactoryGirl.create :podcast, title: 'Moscow' }
  let!(:podcast_london) { FactoryGirl.create :podcast, title: 'London' }

  describe 'search results' do
    subject(:results) { Search.call query }

    context 'when search "mos"' do
      let(:query) { 'mos' }

      it { is_expected.to include podcast_moscow }
      it { is_expected.not_to include podcast_london }
    end
  end
end
