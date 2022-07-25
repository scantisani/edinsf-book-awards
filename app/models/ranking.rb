class Ranking < ApplicationRecord
  belongs_to :book
  validates :book, uniqueness: true

  validates :position,
    presence: true,
    numericality: {greater_than_or_equal_to: 0, less_than_or_equal_to: 11, only_integer: true}
end
