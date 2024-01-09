class CreateSelectedFoods < ActiveRecord::Migration[7.1]
  def change
    create_table :selected_foods do |t|
      t.references :order, null: false, foreign_key: true
      t.references :food, null: false, foreign_key: true

      t.timestamps
    end
  end
end
