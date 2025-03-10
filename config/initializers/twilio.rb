require "twilio-ruby"

# Twilio configuration
Twilio.configure do |config|
  config.account_sid = ENV["TWILIO_ACCOUNT_SID"]
  config.auth_token = ENV["TWILIO_AUTH_TOKEN"]
end

# Create a global Twilio client for use throughout the app
TWILIO_CLIENT = Twilio::REST::Client.new
TWILIO_PHONE_NUMBER = ENV["TWILIO_PHONE_NUMBER"] 