class User < ApplicationRecord
  belongs_to :role

  has_many :assigned_leads, class_name: "Lead", foreign_key: :assigned_cre_id, dependent: :nullify
  has_many :owned_leads, class_name: "Lead", foreign_key: :assigned_sales_exec_id, dependent: :nullify
  has_many :activities, dependent: :nullify
  has_many :follow_ups, dependent: :nullify

  validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: true

  def name
    "#{first_name} #{last_name}"
  end
end
