class Category < ApplicationRecord
  has_many :jobs
  has_many :trainings

  validates :name, presence: true
end
