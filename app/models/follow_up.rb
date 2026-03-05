class FollowUp < ApplicationRecord
  STATUSES = %w[pending done missed].freeze

  belongs_to :lead
  belongs_to :user, optional: true

  validates :due_on, presence: true
  validates :status, inclusion: { in: STATUSES }
end
