class TrainingRegistration < ApplicationRecord
  belongs_to :student
  belongs_to :training

  validates :student_id, uniqueness: { scope: :training_id }
  validate :training_not_full, on: :create

  private

  def training_not_full
    errors.add(:training, "est complete") if training&.full?
  end
end
