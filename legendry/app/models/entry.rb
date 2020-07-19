class Entry < ApplicationRecord
  belongs_to :specification
  validates :title, presence: true
  validates :description, presence: true

  def number_description
    n = number.nil? ? "TBD" : number.to_s
    (parent_number.nil? || parent_number.empty?) ? n : "#{parent_number}.#{n}"
  end
end
