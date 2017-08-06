class WelcomeController < ApplicationController
  def index
    render plain: 'Welcome'
  end
end
