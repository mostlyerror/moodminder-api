# MoodMinder API

MoodMinder is an API for sending automated daily text messages to users inquiring about their mood. Users can respond with emoji faces that correspond to different feelings and emotions. The system records these responses for tracking mood patterns over time.

## Features

- **Daily Text Messages**: Sends automated mood check-ins once per day.
- **Emoji Response System**: Users respond by selecting emoji faces that represent their mood.
- **Multiple Selection**: Users can select multiple emoji faces in a single response.
- **Timezone Aware**: Respects user's timezone to send messages at appropriate times.
- **Message History**: Keeps a record of all sent and received messages.
- **User Management**: Simple API for registering and unregistering users.

## Technical Stack

- **Framework**: Ruby on Rails 7.2
- **Database**: PostgreSQL
- **SMS Service**: Twilio
- **Scheduling**: Whenever gem (cron job wrapper)

## Getting Started

### Prerequisites

- Ruby 3.x
- PostgreSQL
- Twilio account

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/moodminder-api.git
   cd moodminder-api
   ```

2. Install dependencies:
   ```bash
   bundle install
   ```

3. Set up the database:
   ```bash
   rails db:create db:migrate db:seed
   ```

4. Set up environment variables:
   Create a `.env` file in the root directory with the following variables:
   ```
   TWILIO_ACCOUNT_SID=your_twilio_account_sid
   TWILIO_AUTH_TOKEN=your_twilio_auth_token
   TWILIO_PHONE_NUMBER=your_twilio_phone_number
   ```

5. Set up the scheduler:
   ```bash
   bundle exec whenever --update-crontab
   ```

### Running the API

```bash
rails server
```

## API Endpoints

### User Registration

Register a new user for mood check-ins:

```
POST /api/v1/users/register
```

Request body:
```json
{
  "user": {
    "phone_number": "+1234567890",
    "timezone": "America/New_York"
  }
}
```

### User Unregistration

Unregister a user from mood check-ins:

```
POST /api/v1/users/unregister
```

Request body:
```json
{
  "user": {
    "phone_number": "+1234567890"
  }
}
```

### Webhook Endpoint

Endpoint for Twilio to send incoming SMS:

```
POST /api/v1/webhooks/twilio_sms
```

## How It Works

1. **Registration**: Users are registered via the API with their phone number and timezone.
2. **Daily Check-ins**: Every day at a specified time, the system sends a text message asking users about their mood, listing emoji options.
3. **User Response**: Users respond with one or more emoji faces.
4. **Processing**: The system processes the response, records the mood entry, and sends a confirmation.
5. **Tracking**: Mood entries are stored in the database for later analysis.

## Mood Options

The system comes pre-configured with the following mood options:

- 😃 - Happy
- 😞 - Sad
- 😠 - Angry
- 😨 - Anxious
- 🥱 - Tired
- 😐 - Neutral
- 🤔 - Thoughtful
- 🤗 - Grateful
- 😌 - Peaceful
- 🙂 - Content

## Development

### Running Tests

```bash
rails test
```

### Manual Testing

You can manually trigger a mood check-in to a specific user:

```bash
rails runner "SmsService.send_mood_check_in(User.find_by(phone_number: '+1234567890'))"
```

## Production Deployment

For production deployment, make sure to:

1. Set proper environment variables
2. Configure your web server (Nginx, Apache, etc.)
3. Set up SSL certificates for secure communication
4. Configure your Twilio webhook URL to point to your production server

## License

This project is licensed under the MIT License - see the LICENSE file for details.
