class Activity < ApplicationRecord
  KINDS = %w[call whatsapp follow_up note].freeze

  belongs_to :lead
  belongs_to :user, optional: true

  validates :kind, inclusion: { in: KINDS }
  validates :occurred_at, presence: true
end
