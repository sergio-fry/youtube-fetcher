source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '5.2.6'

gem 'pg', '~> 0.21'
gem 'sqlite3'

gem 'bootstrap_form', '>= 4.2.0'
gem 'browser'
gem 'carrierwave', '~> 1.0'
gem 'carrierwave-ftp', require: 'carrierwave/storage/ftp'
gem 'cells-erb'
gem 'cells-rails'
gem 'dalli'
gem 'delayed_cron_job'
gem 'delayed_job_active_record'
gem 'dotenv-rails'
gem 'flipper'
gem 'flipper-active_record'
gem 'fog-aws'
gem 'font-awesome-rails'
gem 'jbuilder', '~> 2.5'
gem 'kaminari'
gem 'localeapp', group: :production
gem 'newrelic_rpm', group: :production
gem 'puma', '>= 3.12.6'
gem 'rails-html-sanitizer', '~> 1.0'
gem 'sass-rails', '~> 5.0'
gem 'simple_metric'
gem 'slack-notifier'
gem 'staccato'
gem 'uglifier', '>= 1.3.0'
gem 'user-agent-randomizer', require: 'user_agent_randomizer'
gem 'webpacker', '~> 3.0'
gem 'yt'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
  gem 'rspec-rails'
  gem 'rspec-its'
  gem 'rspec-cells'
  gem 'factory_girl_rails'
  gem 'pry'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'spring-commands-rspec'
  gem 'i18n-tasks', '~> 0.9.29'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

group :test do
  gem 'vcr'
  gem 'webmock'
  gem 'database_cleaner'
  gem 'simplecov', require: false
  gem 'timecop'
end
