class Food < ApplicationRecord
self.inheritance_column = :_type_disabled
has_many :selected_foods
validates :name, presence: true
validates :price, presence: true

end
