class LeadStageTransition < ApplicationRecord
  belongs_to :lead
  belongs_to :from_stage, class_name: "LeadStage", optional: true
  belongs_to :to_stage, class_name: "LeadStage"
  belongs_to :user, optional: true

  validates :to_stage, presence: true
end
