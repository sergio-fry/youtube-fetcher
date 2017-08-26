require 'rails_helper'

RSpec.describe CleanupLocalMediaJob, type: :job do
  it 'should work' do
    described_class.new.perform
  end
end
