class Table < ApplicationRecord
  has_many :orders
  has_one :waiter, through: :orders
  belongs_to :user
  validates :number, presence: true
  validates :status, inclusion: { in: %w(empty reserved available checkout)}
  validates :number, uniqueness: true
  before_validation :set_default_status
  before_validation :set_default_customer

  def set_default_status
    if self.status == "" || self.status == nil
      self.status = "empty"
    end
  end

  def set_default_customer
    if self.customer_number == "" || self.customer_number == nil
      self.customer_number = 0
    end
  end

end
