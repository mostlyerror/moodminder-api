class User < ApplicationRecord
  has_secure_password
  
  validates :email, presence: true, uniqueness: true,
            format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, length: { minimum: 6 }, if: -> { new_record? || !password.nil? }
  validates :phone_number, uniqueness: true, allow_nil: true,
            format: { with: /\A\+?[\d\-\s\(\)]+\z/, message: "must be a valid phone number" }

  # Remove any non-digit characters before saving phone number
  before_save :normalize_phone_number

  private

  def normalize_phone_number
    return if phone_number.nil?
    self.phone_number = phone_number.gsub(/[^\d+]/, '')
  end
end 