class Training < ApplicationRecord
  belongs_to :trainer
  belongs_to :category, optional: true
  has_many :training_registrations, dependent: :destroy
  has_many :students, through: :training_registrations

  validates :title, presence: true

  def full?
    capacity.present? && training_registrations.count >= capacity
  end
end
