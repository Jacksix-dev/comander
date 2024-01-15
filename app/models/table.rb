class Table < ApplicationRecord
  has_many :orders
  belongs_to :user

  # enum status: { empty: "Vacia", reserved: "Reservado", available: "Disponible", checkout: "Pagando" }
  enum status: { empty: 0, reserved: 1, full: 2, checkout: 3 }

  has_one :waiter, through: :orders
  has_one :kitchen, through: :orders
  validate :customers_presence_for_non_empty_tables

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

  def customers_presence_for_non_empty_tables
    if (status == 'full' || status == 'checkout') && customer_number.zero?
      errors.add(:customer_number, "must be greater than 0 for 'full' or 'checkout' status")
    end
  end

end
