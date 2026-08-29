class Trainer < ApplicationRecord
  belongs_to :user
  has_many :trainings, dependent: :destroy

  validates :first_name, :last_name, presence: true
end
