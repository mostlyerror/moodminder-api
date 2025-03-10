class MoodEntry < ApplicationRecord
  belongs_to :user
  
  validates :mood_options, presence: true
  validates :timestamp, presence: true

  # Store mood_options as a serialized array of emojis
  serialize :mood_options, Array

  # Get the actual MoodOption objects associated with this entry
  def mood_option_objects
    MoodOption.where(emoji: mood_options)
  end
end
