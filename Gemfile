source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }
ruby "3.2.1"
gem "bootstrap"
gem 'googlecharts'
gem 'bootstrap-icons'
gem 'google-analytics-rails', '1.1.1'
gem 'kaminari'
gem 'free_disk_space'
gem 'friendly_id', '~> 5.4.0'
gem 'slim-rails'
gem "font-awesome-rails"
gem "groupdate"
gem 'pg'
gem 'rubyzip'
gem 'zip-zip' # will load compatibility for old rubyzip API.
gem 'ransack'
gem 'jquery-rails'
gem 'active_storage_validations'
gem "ruby-openai"
gem "csv"
gem "chartkick"
gem 'mini_magick'
gem 'rmagick'
gem "meta-tags"
gem 'fastimage'
gem 'hash_diff'
gem 'byebug'
gem 'httparty'
gem 'simple_form'
gem 'google-api-client', '~> 0.9', require: 'google/apis/gmail_v1'
gem 'rss'
gem 'feedjira'
gem 'whenever'
#gem "koala"
# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.0.4", ">= 7.0.4.2"

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem "sprockets-rails"

# Use sqlite3 as the database for Active Record


# Use the Puma web server [https://github.com/puma/puma]
gem "puma", "~> 5.0"

# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem "importmap-rails"

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails"

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "jbuilder"

# Use Redis adapter to run Action Cable in productionb:5: warning: previous definition of BOOTSTRAP_SHA was here

# gem "redis", "~> 4.0"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
 gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Use Sass to process CSS
gem "sassc-rails"

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
gem "image_processing", "~> 1.2"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler"

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
  gem 'capistrano'
  gem 'capistrano-rails'
  gem 'capistrano-passenger'
  gem 'capistrano-rbenv'
end

group :test do
  gem "sqlite3", "~> 1.4"
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"
end

gem "sidekiq", "~> 7.2"

