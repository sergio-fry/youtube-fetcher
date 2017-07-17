require 'rails_helper'

RSpec.describe "channels/show", type: :view do
  subject { rendered }
  before do
    assign(:channel, double(:channel, title: 'My Podcast'))
    assign(:podcast, FactoryGirl.build(:podcast))
    assign(:videos, [FactoryGirl.build(:episode, title: 'My Episode')])

    render
  end

  it { is_expected.to include 'My Podcast' }
  it { is_expected.to include 'My Episode' }
end
