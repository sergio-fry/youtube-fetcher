require 'rails_helper'

RSpec.describe Podcast, type: :model do
  subject { build(:podcast) }
  it { should have_many(:episodes).dependent(:destroy) }
  it { should validate_presence_of(:origin_id) }
end
