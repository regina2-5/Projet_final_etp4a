class Company < ApplicationRecord
  belongs_to :user
  has_many :jobs, dependent: :destroy

  validates :name, presence: true

  scope :validated, -> { where(validated: true) }
end
