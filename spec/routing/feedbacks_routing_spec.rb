require "rails_helper"

RSpec.describe FeedbacksController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/feedbacks").to route_to("feedbacks#index")
    end

    it "routes to #new" do
      expect(:get => "/feedbacks/new").to route_to("feedbacks#new")
    end

    it "routes to #show" do
      expect(:get => "/feedbacks/1").to route_to("feedbacks#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/feedbacks/1/edit").to route_to("feedbacks#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/feedbacks").to route_to("feedbacks#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/feedbacks/1").to route_to("feedbacks#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/feedbacks/1").to route_to("feedbacks#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/feedbacks/1").to route_to("feedbacks#destroy", :id => "1")
    end
  end
end
