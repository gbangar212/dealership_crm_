class CreateLeads < ActiveRecord::Migration[8.0]
  def change
    create_table :leads do |t|
      t.string :lead_number
      t.string :source
      t.string :sub_source
      t.string :campaign_name
      t.references :current_stage, null: false, foreign_key: { to_table: :lead_stages }
      t.references :assigned_cre, foreign_key: { to_table: :users }
      t.references :assigned_sales_exec, foreign_key: { to_table: :users }

      t.string :customer_name, null: false
      t.string :mobile_number, null: false
      t.string :alternate_number
      t.string :email
      t.string :city
      t.text :address

      t.string :interested_model
      t.string :variant
      t.string :fuel_type
      t.string :color_preference
      t.string :budget_range

      t.integer :lead_score
      t.string :temperature
      t.date :expected_purchase_on

      t.datetime :last_call_at
      t.datetime :last_whatsapp_at
      t.date :next_follow_up_on
      t.integer :follow_up_count, null: false, default: 0
      t.text :notes

      t.decimal :booking_amount, precision: 12, scale: 2
      t.date :booking_date
      t.string :payment_mode
      t.date :delivery_date

      t.timestamps
    end

    add_index :leads, :mobile_number, unique: true
    add_index :leads, :lead_number
    add_index :leads, :source
  end
end
