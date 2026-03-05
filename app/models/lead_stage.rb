class LeadStage < ApplicationRecord
  has_many :leads, foreign_key: :current_stage_id, dependent: :nullify
  has_many :from_transitions, class_name: "LeadStageTransition", foreign_key: :from_stage_id, dependent: :nullify
  has_many :to_transitions, class_name: "LeadStageTransition", foreign_key: :to_stage_id, dependent: :nullify

  validates :name, presence: true, uniqueness: true
  validates :position, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
