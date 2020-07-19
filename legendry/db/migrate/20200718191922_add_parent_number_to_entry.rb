class AddParentNumberToEntry < ActiveRecord::Migration[6.0]
  def change
    add_column :entries, :parent_number, :string
  end
end
