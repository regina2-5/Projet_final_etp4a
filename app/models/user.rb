class User < ApplicationRecord
  has_secure_password

  belongs_to :role
  has_one :student, dependent: :destroy
  has_one :company, dependent: :destroy
  has_one :trainer, dependent: :destroy

  has_many :sent_messages, class_name: "Message", foreign_key: :sender_id, dependent: :destroy
  has_many :received_messages, class_name: "Message", foreign_key: :receiver_id, dependent: :destroy
  has_many :notifications, dependent: :destroy

  validates :email, presence: true, uniqueness: true,
            format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, length: { minimum: 8 }, if: -> { new_record? || !password.nil? }

  def student?
    role&.name == "student"
  end

  def company?
    role&.name == "company"
  end

  def trainer?
    role&.name == "trainer"
  end

  def admin?
    role&.name == "admin"
  end
end
