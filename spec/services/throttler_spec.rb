require 'rails_helper'

RSpec.describe Throttler do
  let(:throttler) { described_class.new period, 'test action' }
  let(:period) { 1.minute }
  let(:object) do
    obj = double(:object)
    allow(obj).to receive(:touch)

    obj
  end

  before { Rails.cache.clear }

  it 'should make an action' do
    expect(object).to receive(:touch)

    throttler.action do
      object.touch
    end
  end

  it 'should not make an action twice a time' do
    expect(object).to receive(:touch).once

    throttler.action do
      object.touch
    end

    throttler.action do
      object.touch
    end
  end

  it 'should make an action second time after a while' do
    throttler.action do
      object.touch
    end

    expect(object).to receive(:touch)

    Timecop.travel 2.minutes.from_now do
      throttler.action do
        object.touch
      end
    end
  end
end
