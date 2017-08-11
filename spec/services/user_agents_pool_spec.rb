require 'rails_helper'

RSpec.describe UserAgentsPool do
  describe '.with_user_agent' do
    context 'a single user exists' do
      let!(:user_agent) { FactoryGirl.create :user_agent }

      it 'should get free user' do
        described_class.with_user_agent do |ua|
          expect(ua).to eq user_agent
        end
      end

      it 'should update last_pageview_at' do
        expect do
          described_class.with_user_agent {}
        end.to change { user_agent.reload.last_pageview_at }
      end
    end

    context 'when user_agent is used recently' do
      let!(:user_agent) { FactoryGirl.create :user_agent, last_pageview_at: 5.seconds.ago }

      it 'should raise error' do
        expect do
          described_class.with_user_agent {}
        end.to raise_error(described_class::NoFreeUsersLeft)
      end
    end

    context 'has 2 users' do
      let!(:user_agent_1_hour_ago) { FactoryGirl.create :user_agent, last_pageview_at: 1.hour.ago }
      let!(:user_agent_2_hours_ago) { FactoryGirl.create :user_agent, last_pageview_at: 2.hour.ago }

      it 'should get user having longer idle time' do
        described_class.with_user_agent do |ua|
          expect(ua).to eq user_agent_2_hours_ago
        end
      end
    end
  end

  describe '.generate' do
    it 'should create a user agent' do
      user_agent = described_class.generate
      expect(user_agent).to be_a UserAgent
      expect(user_agent).to be_valid
      expect(user_agent).to be_persisted
    end
  end
end
