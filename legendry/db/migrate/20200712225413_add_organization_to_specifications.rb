class AddOrganizationToSpecifications < ActiveRecord::Migration[6.0]
  def change
    add_reference :specifications, :organization, null: false, foreign_key: true
  end
end
