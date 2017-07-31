require 'rails_helper'

RSpec.describe 'channels/show', type: :view do
  subject { rendered }
  let(:podcast) { create(:podcast) }
  before do
    assign(:channel, double(:channel, title: 'My Podcast'))
    assign(:podcast, podcast)
    assign(:videos, [create(:episode, title: 'My Episode')])

    render
  end

  it { is_expected.to include 'My Podcast' }
  it { is_expected.to include 'My Episode' }
  it { is_expected.to include channel_url(podcast.origin_id, format: :atom) }

  context 'when playlist' do
    let(:podcast) { create(:podcast, :playlist) }

    it { is_expected.to include playlist_url(podcast.origin_id, format: :atom) }
  end
end
