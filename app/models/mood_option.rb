class MoodOption < ApplicationRecord
  validates :emoji, presence: true, uniqueness: true
  validates :name, presence: true, uniqueness: true
  validates :description, presence: true

  # Class method to get a formatted list of all mood options for SMS
  def self.formatted_for_sms
    all.map { |option| "#{option.emoji} - #{option.name}" }.join("\n")
  end

  # Class method to find a mood option by emoji
  def self.find_by_emoji(emoji)
    find_by(emoji: emoji)
  end
end
