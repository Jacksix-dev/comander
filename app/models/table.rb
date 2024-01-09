class Table < ApplicationRecord
  has_many :orders
  has_one :waiter, through: :orders
  belongs_to :user
  validates :number, presence: true
  validates :status, inclusion: { in: %w(empty reserved available checkout)}
end
