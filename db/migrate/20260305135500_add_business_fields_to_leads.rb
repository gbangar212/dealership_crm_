class AddBusinessFieldsToLeads < ActiveRecord::Migration[8.0]
  def change
    add_column :leads, :customer_occupation, :string
    add_column :leads, :company_name, :string
    add_column :leads, :purchase_type, :string
    add_column :leads, :is_exchange, :boolean, default: false, null: false
    add_column :leads, :competition_car, :string
    add_column :leads, :finance_status, :string
  end
end
