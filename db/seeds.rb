# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Create mood options with emojis
mood_options = [
  { emoji: "😃", name: "Happy", description: "Feeling cheerful, optimistic, and content." },
  { emoji: "😞", name: "Sad", description: "Feeling down, gloomy, or unhappy." },
  { emoji: "😠", name: "Angry", description: "Feeling resentful, irritated, or enraged." },
  { emoji: "😨", name: "Anxious", description: "Feeling worried, nervous, or uneasy." },
  { emoji: "🥱", name: "Tired", description: "Feeling fatigued, exhausted, or sleepy." },
  { emoji: "😐", name: "Neutral", description: "Feeling emotionally balanced, neither positive nor negative." },
  { emoji: "🤔", name: "Thoughtful", description: "Feeling contemplative, reflective, or deep in thought." },
  { emoji: "🤗", name: "Grateful", description: "Feeling thankful, appreciative, or blessed." },
  { emoji: "😌", name: "Peaceful", description: "Feeling calm, serene, or at ease." },
  { emoji: "🙂", name: "Content", description: "Feeling satisfied, at ease, and comfortable." }
]

# Add mood options if they don't exist
mood_options.each do |option|
  MoodOption.find_or_create_by!(emoji: option[:emoji]) do |mood_option|
    mood_option.name = option[:name]
    mood_option.description = option[:description]
  end
end

puts "Created #{MoodOption.count} mood options"
