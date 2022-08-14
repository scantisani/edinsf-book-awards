class User < ApplicationRecord
  has_many :rankings, dependent: :destroy

  validates :uuid,
    presence: true,
    uniqueness: true,
    format: /\A[0-9a-f]{8}-[0-9a-f]{4}-[0-5][0-9a-f]{3}-[089ab][0-9a-f]{3}-[0-9a-f]{12}\z/i

  validates :name, presence: true

  attribute :uuid, default: -> { SecureRandom.uuid }
end
