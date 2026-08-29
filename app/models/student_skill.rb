class StudentSkill < ApplicationRecord
  belongs_to :student
  belongs_to :skill

  validates :student_id, uniqueness: { scope: :skill_id }
  validates :level, inclusion: { in: 1..5 }
end
