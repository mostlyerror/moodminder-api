class User < ApplicationRecord
  has_many :mood_entries, dependent: :destroy
  has_many :messages, dependent: :destroy

  validates :phone_number, presence: true, uniqueness: true
  validates :timezone, presence: true
  validates :active, inclusion: { in: [true, false] }

  # Format phone number to E.164 format for Twilio
  before_save :format_phone_number

  def format_phone_number
    # Remove any non-digit characters
    digits = phone_number.gsub(/\D/, '')
    
    # Add the plus sign if not already there
    self.phone_number = if digits.start_with?('1')
                          "+#{digits}"
                        elsif !digits.start_with?('+')
                          "+1#{digits}"
                        else
                          digits
                        end
  end
end
