if ENV['LOCALEAPP_API_KEY'].present?
  require 'localeapp/rails'

  Localeapp.configure do |config|
    config.api_key = ENV['LOCALEAPP_API_KEY']
  end
end
