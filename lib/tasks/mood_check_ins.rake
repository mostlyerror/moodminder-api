namespace :mood_check_ins do
  desc "Send mood check-in messages to all active users"
  task send: :environment do
    # Get all active users
    active_users = User.where(active: true)
    
    puts "Sending mood check-ins to #{active_users.count} users..."
    
    # Send mood check-in to each user
    active_users.each do |user|
      # Check if it's an appropriate time in the user's timezone
      # Default to sending between 9 AM and 8 PM in the user's local time
      user_time = Time.current.in_time_zone(user.timezone || "UTC")
      
      if user_time.hour >= 9 && user_time.hour < 20
        puts "Sending mood check-in to user #{user.id} (#{user.phone_number})..."
        
        if SmsService.send_mood_check_in(user)
          puts "  Success!"
        else
          puts "  Failed to send message."
        end
      else
        puts "Skipping user #{user.id} - outside of acceptable hours in their timezone."
      end
    end
    
    puts "Mood check-in task completed."
  end
end 