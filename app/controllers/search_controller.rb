class SearchController < ApplicationController
  def index
    @results = Search.new.call params[:q]
  end
end
