class Book < ApplicationRecord
  validates :title, presence: true
  validates :author, presence: true
  validates :published_at, presence: true
  validates :read_at, presence: true, uniqueness: true
  validates :chosen_by, presence: true
end
