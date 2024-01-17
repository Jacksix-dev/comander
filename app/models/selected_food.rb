class SelectedFood < ApplicationRecord
  belongs_to :order
  belongs_to :food
  validates :food, presence: true
end
