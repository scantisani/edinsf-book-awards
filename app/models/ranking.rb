class Ranking < ApplicationRecord
  belongs_to :book
  belongs_to :user

  validates :book, uniqueness: {scope: :user}

  validates :position,
    presence: true,
    numericality: {greater_than_or_equal_to: 0, less_than_or_equal_to: 11, only_integer: true}
end
