require 'rails_helper'

RSpec.describe Episode, type: :model do
  subject { build(:episode) }
  it { should belong_to(:podcast) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:published_at) }
end
