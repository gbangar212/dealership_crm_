class CreateGateEntries < ActiveRecord::Migration[8.0]
  def change
    create_table :gate_entries do |t|
      t.string :vin, null: false
      t.string :make, null: false
      t.string :model, null: false
      t.integer :year, null: false
      t.string :color
      t.integer :mileage
      t.date :arrived_at, null: false
      t.string :stock_number
      t.string :status, null: false, default: "received"
      t.text :notes

      t.timestamps
    end

    add_index :gate_entries, :vin, unique: true
    add_index :gate_entries, :arrived_at
    add_index :gate_entries, :status
  end
end
