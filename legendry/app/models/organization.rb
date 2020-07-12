class Organization < ApplicationRecord
  has_many :specifications
  validates :name, presence: true
end
