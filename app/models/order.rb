class Order < ApplicationRecord
  belongs_to :waiter
  belongs_to :kitchen
  belongs_to :table
end
