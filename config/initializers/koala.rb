Koala.configure do |config|
  config.access_token = Rails.application.credentials.facebook[:access_token]
  config.app_access_token = Rails.application.credentials.facebook[:app_access_token]
  config.app_id = Rails.application.credentials.facebook[:app_id]
  # See Koala::Configuration for more options, including details on how to send requests through
  # your own proxy servers.  
end
