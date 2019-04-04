require 'rails_helper'

RSpec.describe "Feedbacks", type: :request do
  describe "GET /feedbacks" do
    it "works! (now write some real specs)" do
      get feedbacks_path
      expect(response).to have_http_status(200)
    end
  end
end
