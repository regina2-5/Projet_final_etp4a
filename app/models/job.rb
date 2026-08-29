class Job < ApplicationRecord
  belongs_to :company
  belongs_to :category, optional: true
  has_many :applications, dependent: :destroy
  has_many :students, through: :applications

  validates :title, presence: true

  scope :active, -> { where(active: true) }

  # Recommandation simple : offres dont la categorie correspond
  # aux competences de l'etudiant.
  def self.recommended_for(student)
    skill_ids = student.skill_ids
    return active if skill_ids.empty?
    active.where(category_id: student.skills.joins(:students).select(:id))
  end
end
