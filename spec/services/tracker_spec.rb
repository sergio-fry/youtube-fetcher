require 'rails_helper'

RSpec.describe Tracker do
  it 'should track event' do
    VCR.use_cassette :google_analytics_event do
      expect do
        Tracker.event category: :video, action: :download, label: 'ABC123'
      end.not_to raise_error
    end
  end
end

