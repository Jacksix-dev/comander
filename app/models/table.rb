class Table < ApplicationRecord
  has_many :orders
  belongs_to :user

  # enum status: { empty: "Vacia", reserved: "Reservado", available: "Disponible", checkout: "Pagando" }
  enum status: { empty: 0, reserved: 1, available: 2, checkout: 3 }

  has_one :waiter, through: :orders
  has_one :kitchen, through: :orders


  validates :number, presence: true
  validates :number, uniqueness: true
  before_validation :set_default_status
  before_validation :set_default_customer

  def set_default_status
    self.status ||= "empty" if self.class.statuses.key?(self.status.to_s)
  end

  def set_default_customer
    self.customer_number ||= 0
  end
end
