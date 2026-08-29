class Student < ApplicationRecord
  belongs_to :user

  has_many :student_skills, dependent: :destroy
  has_many :skills, through: :student_skills
  has_many :applications, dependent: :destroy
  has_many :jobs, through: :applications
  has_many :training_registrations, dependent: :destroy
  has_many :trainings, through: :training_registrations

  validates :first_name, :last_name, presence: true
end
