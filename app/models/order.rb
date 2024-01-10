class Order < ApplicationRecord
  has_many :selected_foods
  belongs_to :table
  belongs_to :waiter
  belongs_to :kitchen
  has_many :foods, through: :selected_foods
end
