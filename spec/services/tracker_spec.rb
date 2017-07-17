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
      obj = double(:obj)
      expect(obj).to receive(:ping)

      expect do
        Tracker.timing(category: 'runtime', variable: 'youtube-dl', label: 'download') do
          obj.ping
        end
      end.not_to raise_error
    end
  end
end

