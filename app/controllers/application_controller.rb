class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  rescue_from ActiveRecord::RecordNotFound do
    render plain: 'Not found', status: 404
  end
end
