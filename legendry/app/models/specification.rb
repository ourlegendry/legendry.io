class Specification < ApplicationRecord
  belongs_to :organization
  has_many :entries
  validates :title, presence: true
end
