class Entry < ApplicationRecord
  belongs_to :specification
  validates :title, presence: true
  validates :description, presence: true
end
