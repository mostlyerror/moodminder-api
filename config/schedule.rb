# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Set output path for logging
set :output, "log/cron.log"

# Set environment to the current Rails environment
set :environment, ENV["RAILS_ENV"] || "development"

# Send mood check-ins every day at 10:00 AM
# This will be adjusted based on each user's timezone in the task
every 1.day, at: "10:00 am" do
  rake "mood_check_ins:send"
end

# Learn more: http://github.com/javan/whenever
