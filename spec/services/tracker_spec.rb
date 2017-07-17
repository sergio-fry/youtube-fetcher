require 'rails_helper'

RSpec.describe Tracker do
  it 'should track event' do
    VCR.use_cassette :google_analytics_event do
      expect do
        Tracker.event category: :video, action: :download, label: 'ABC123'
      end.not_to raise_error
    end
  end

  it 'should track timing' do
    VCR.use_cassette :google_analytics_timing do
      expect do
        Tracker.timing(category: 'runtime', variable: 'youtube-dl', label: 'download') do
          sleep 0.001
        end
      end.not_to raise_error
    end
  end
end

