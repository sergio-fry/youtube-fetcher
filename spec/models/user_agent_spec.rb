require 'rails_helper'

RSpec.describe UserAgent, type: :model do
  describe '#cookies_jar' do
    after do
      `rm -rf #{Rails.root.join('tmp', 'cookies', '*')}`
    end

    context 'when cookies is blank' do
      let!(:user_agent) { FactoryGirl.create :user_agent, cookies: nil }

      it 'should not be exists' do
        expect(File.exists?(user_agent.cookies_jar.path)).to eq false
      end
    end

    context 'when cookies is present' do
      let!(:user_agent) { FactoryGirl.create :user_agent, cookies: 'some cookie content' }

      it 'should be exists' do
        expect(File.exists?(user_agent.cookies_jar.path)).to eq true
      end
    end
  end
end
