class CreateTables < ActiveRecord::Migration[7.1]
  def change
    create_table :tables do |t|
      t.integer :number
      t.integer :customer_number
      t.integer :total_expended
      t.string :status
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
