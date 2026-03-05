class AddStateToLeads < ActiveRecord::Migration[8.0]
  def change
    add_column :leads, :state, :string
  end
end
