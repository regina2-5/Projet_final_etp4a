class Application < ApplicationRecord
  belongs_to :student
  belongs_to :job

  STATUSES = %w[pending accepted rejected].freeze

  validates :status, inclusion: { in: STATUSES }
  validates :student_id, uniqueness: { scope: :job_id, message: "a deja postule a cette offre" }
end
