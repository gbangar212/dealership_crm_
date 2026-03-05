class CreateLeadStageTransitions < ActiveRecord::Migration[8.0]
  def change
    create_table :lead_stage_transitions do |t|
      t.references :lead, null: false, foreign_key: true
      t.references :from_stage, foreign_key: { to_table: :lead_stages }
      t.references :to_stage, null: false, foreign_key: { to_table: :lead_stages }
      t.references :user, foreign_key: true
      t.text :notes
      t.timestamps
    end

    add_index :lead_stage_transitions, :created_at
  end
end
