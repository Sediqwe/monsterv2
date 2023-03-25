# Load the Rails application.
require_relative "application"
require 'ipinfo-rails'
config.middleware.use(IPinfoMiddleware, {token: "37debcd96d5bd7"})
# Initialize the Rails application.
Rails.application.initialize!


