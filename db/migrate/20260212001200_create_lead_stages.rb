class CreateLeadStages < ActiveRecord::Migration[8.0]
  def change
    create_table :lead_stages do |t|
      t.string :name, null: false
      t.integer :position, null: false, default: 0
      t.boolean :active, null: false, default: true
      t.timestamps
    end

    add_index :lead_stages, :name, unique: true
    add_index :lead_stages, :position
  end
end
