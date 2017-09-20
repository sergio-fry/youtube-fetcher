require 'rails_helper'

RSpec.describe VideosController, type: :controller do
  render_views

  describe "GET #show" do
    let!(:episode) { FactoryGirl.create :episode }

    it "returns http success" do
      get :show, params: { id: episode.origin_id }
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #index" do
    let!(:episode) { FactoryGirl.create :episode }

    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

end
