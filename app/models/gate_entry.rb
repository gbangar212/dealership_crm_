class GateEntry < ApplicationRecord
  STATUSES = ["received", "inspected", "ready", "held"].freeze

  validates :vin, presence: true, uniqueness: true
  validates :make, :model, :year, :arrived_at, presence: true
  validates :year, numericality: { only_integer: true, greater_than: 1900 }
  validates :mileage, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_nil: true
  validates :status, inclusion: { in: STATUSES }
end
