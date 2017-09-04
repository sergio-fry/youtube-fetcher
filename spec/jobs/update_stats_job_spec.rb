require 'rails_helper'

RSpec.describe UpdateStatsJob, type: :job do
  it 'should work' do
    described_class.new.perform
  end
end
