class Message < ApplicationRecord
  belongs_to :user

  # Constants for direction
  INBOUND = "inbound".freeze
  OUTBOUND = "outbound".freeze

  # Constants for status
  SENT = "sent".freeze
  DELIVERED = "delivered".freeze
  FAILED = "failed".freeze
  RECEIVED = "received".freeze

  validates :content, presence: true
  validates :direction, presence: true, inclusion: { in: [ INBOUND, OUTBOUND ] }
  validates :status, presence: true, inclusion: { in: [ SENT, DELIVERED, FAILED, RECEIVED ] }
  validates :sent_at, presence: true

  # Scope for retrieving messages in chronological order
  scope :chronological, -> { order(sent_at: :asc) }
  
  # Helper method to create an outbound message
  def self.create_outbound(user, content, metadata = {})
    create(
      user: user,
      content: content,
      direction: OUTBOUND,
      status: SENT,
      metadata: metadata,
      sent_at: Time.current
    )
  end
  
  # Helper method to create an inbound message
  def self.create_inbound(user, content, metadata = {})
    create(
      user: user,
      content: content,
      direction: INBOUND,
      status: RECEIVED,
      metadata: metadata,
      sent_at: Time.current
    )
  end
end
