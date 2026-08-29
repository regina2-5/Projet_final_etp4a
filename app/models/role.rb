class Role < ApplicationRecord
  # name: "student", "company", "trainer", "admin"
  has_many :users
  validates :name, presence: true, uniqueness: true
end
