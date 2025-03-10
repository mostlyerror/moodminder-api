class SmsService
  # Send a text message to a user
  def self.send_message(user, content)
    return false unless user.active && user.phone_number.present?

    begin
      message = TWILIO_CLIENT.messages.create(
        from: TWILIO_PHONE_NUMBER,
        to: user.phone_number,
        body: content
      )

      # Store the message in our database
      Message.create_outbound(user, content, { twilio_sid: message.sid })

      true
    rescue Twilio::REST::RestError => e
      Rails.logger.error("Failed to send SMS to #{user.phone_number}: #{e.message}")
      false
    end
  end

  # Send a mood check-in message to a user
  def self.send_mood_check_in(user)
    message_content = "How are you feeling today? Reply with one or more of these emojis:\n\n"
    message_content += MoodOption.formatted_for_sms
    message_content += "\n\nYou can select multiple options by sending multiple emojis."

    send_message(user, message_content)
  end

  # Process an incoming message from a user
  def self.process_incoming_message(from, body, twilio_params = {})
    # Find the user by phone number
    user = User.find_by(phone_number: from)
    return false unless user

    # Store the incoming message
    Message.create_inbound(user, body, twilio_params)

    # Process the message content (emojis)
    process_mood_response(user, body)
  end

  private

  # Process a user's mood response
  def self.process_mood_response(user, body)
    # Extract emojis from the message
    emojis = body.scan(/\p{Emoji}/).uniq

    return send_invalid_response(user) if emojis.empty?

    # Check if all emojis are valid mood options
    valid_emojis = MoodOption.pluck(:emoji)
    invalid_emojis = emojis - valid_emojis

    if invalid_emojis.any?
      return send_invalid_emoji_response(user, invalid_emojis)
    end

    # Create a new mood entry
    MoodEntry.create!(
      user: user,
      mood_options: emojis,
      timestamp: Time.current
    )

    # Send confirmation message
    mood_names = MoodOption.where(emoji: emojis).pluck(:name).join(", ")
    send_message(user, "Thank you for sharing that you're feeling #{mood_names} today. We've recorded your response.")

    true
  end

  # Send a message for invalid responses (no emojis)
  def self.send_invalid_response(user)
    message = "I didn't recognize any mood emojis in your message. Please respond with one or more of these emojis:\n\n"
    message += MoodOption.formatted_for_sms

    send_message(user, message)
    false
  end

  # Send a message for invalid emojis
  def self.send_invalid_emoji_response(user, invalid_emojis)
    message = "I didn't recognize these emojis: #{invalid_emojis.join(' ')}. Please use only these options:\n\n"
    message += MoodOption.formatted_for_sms

    send_message(user, message)
    false
  end
end
