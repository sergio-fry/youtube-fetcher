require 'rails_helper'

RSpec.describe UserAgentsService do
  describe '.with_user_agent' do
    let!(:user_agent) { FactoryGirl.create :user_agent }

    it 'should get free user' do
      UserAgentsService.with_user_agent do |ua|
        expect(ua).to eq user_agent
      end
    end

    context 'when user_agent is used recently' do
      before { user_agent.update_attribute :last_pageview_at, 5.seconds.ago }

      it 'should get free user' do
        expect do
          UserAgentsService.with_user_agent do |ua|
          end
        end.to raise_error(UserAgentsService::NoFreeUsersLeft)
      end
    end
  end
end
