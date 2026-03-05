class Lead < ApplicationRecord
  TEMPERATURES = %w[hot warm cold].freeze
  SOURCES = %w[ivr whatsapp walk_in website referral].freeze

  before_validation :set_default_current_stage, on: :create

  belongs_to :current_stage, class_name: "LeadStage"
  belongs_to :assigned_cre, class_name: "User", optional: true
  belongs_to :assigned_sales_exec, class_name: "User", optional: true

  has_many :activities, dependent: :destroy
  has_many :follow_ups, dependent: :destroy
  has_many :stage_transitions, class_name: "LeadStageTransition", dependent: :destroy

  validates :customer_name, :mobile_number, presence: true
  validates :mobile_number, uniqueness: true
  validates :temperature, inclusion: { in: TEMPERATURES }, allow_nil: true
  validates :source, inclusion: { in: SOURCES }, allow_nil: true

  private

  def set_default_current_stage
    self.current_stage ||= LeadStage.order(:position, :id).first
  end
end
