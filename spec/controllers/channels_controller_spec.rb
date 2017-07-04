require 'rails_helper'

RSpec.describe ChannelsController, type: :controller do
  render_views
  it 'should fetch channel' do
    get :show, params: { id: 'UCX0nHcqZWDSsAPog-LXdP7A' }, format: :atom
    expect(response).to be_success

    data = Hash.from_xml response.body

    puts data.inspect
    expect(data).to have_key :wfwd
  end
end
