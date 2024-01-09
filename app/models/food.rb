class Food < ApplicationRecord
has_many :selected_foods
validates :name, presence: true
validates :price, presence: true

end
