class CreateActivities < ActiveRecord::Migration[8.0]
  def change
    create_table :activities do |t|
      t.references :lead, null: false, foreign_key: true
      t.references :user, foreign_key: true
      t.string :kind, null: false
      t.datetime :occurred_at, null: false
      t.text :notes
      t.integer :duration_seconds
      t.timestamps
    end

    add_index :activities, :kind
    add_index :activities, :occurred_at
  end
end
