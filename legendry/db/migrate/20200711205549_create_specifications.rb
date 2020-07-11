class CreateSpecifications < ActiveRecord::Migration[6.0]
  def change
    create_table :specifications do |t|
      t.string :title

      t.timestamps
    end
  end
end
