module Api
  module V1
    class WebhooksController < ApplicationController
      # Skip CSRF protection for webhooks
      skip_before_action :verify_authenticity_token

      # Handle incoming SMS from Twilio
      def twilio_sms
        # Get the sender's phone number and message body
        from = params[:From]
        body = params[:Body]

        # Process the incoming message
        SmsService.process_incoming_message(from, body, twilio_params)

        # Respond with empty TwiML to avoid sending a response
        render xml: Twilio::TwiML::MessagingResponse.new.to_xml
      end

      private

      # Extract Twilio parameters for metadata
      def twilio_params
        params.permit(
          :MessageSid, :AccountSid, :MessagingServiceSid, :From, :To,
          :Body, :NumMedia, :NumSegments
        ).to_h.symbolize_keys
      end
    end
  end
end 