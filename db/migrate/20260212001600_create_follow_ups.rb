class CreateFollowUps < ActiveRecord::Migration[8.0]
  def change
    create_table :follow_ups do |t|
      t.references :lead, null: false, foreign_key: true
      t.references :user, foreign_key: true
      t.date :due_on, null: false
      t.string :status, null: false, default: "pending"
      t.datetime :completed_at
      t.text :notes
      t.timestamps
    end

    add_index :follow_ups, :due_on
    add_index :follow_ups, :status
  end
end
