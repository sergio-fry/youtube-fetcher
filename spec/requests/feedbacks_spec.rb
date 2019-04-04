require 'rails_helper'

RSpec.describe "Feedbacks", type: :request do
  describe "GET /feedbacks" do
    it "works! (now write some real specs)" do
      FactoryGirl.create :feedback
      get feedbacks_path, params: { format: :atom }
      expect(response).to have_http_status(200)
    end
  end
end
