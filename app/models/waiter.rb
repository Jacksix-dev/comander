class Waiter < ApplicationRecord
  validates :name, presence: true
  has_many :orders
  has_many :tables, through: :orders
end
