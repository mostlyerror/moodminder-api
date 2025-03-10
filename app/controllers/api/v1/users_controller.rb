module Api
  module V1
    class UsersController < ApplicationController
      # Skip CSRF protection for API
      skip_before_action :verify_authenticity_token

      # Register a new user for mood check-ins
      def register
        # Find or initialize a user by phone number
        @user = User.find_or_initialize_by(phone_number: user_params[:phone_number])
        
        # Update user attributes
        @user.assign_attributes(
          timezone: user_params[:timezone] || "UTC",
          active: true
        )
        
        if @user.save
          # Send a welcome message
          welcome_message = "Welcome to MoodMinder! You're now registered for daily mood check-ins. " \
                           "You'll receive a text message once per day asking about your mood."
          SmsService.send_message(@user, welcome_message)
          
          render json: { success: true, user_id: @user.id }, status: :ok
        else
          render json: { success: false, errors: @user.errors.full_messages }, status: :unprocessable_entity
        end
      end
      
      # Unregister a user from mood check-ins
      def unregister
        @user = User.find_by(phone_number: user_params[:phone_number])
        
        if @user
          @user.update(active: false)
          
          # Send a goodbye message
          goodbye_message = "You've been unregistered from MoodMinder. " \
                           "You will no longer receive daily mood check-ins. " \
                           "Text 'START' to this number if you'd like to re-enable them."
          SmsService.send_message(@user, goodbye_message)
          
          render json: { success: true }, status: :ok
        else
          render json: { success: false, error: "User not found" }, status: :not_found
        end
      end
      
      private
      
      def user_params
        params.require(:user).permit(:phone_number, :timezone)
      end
    end
  end
end 