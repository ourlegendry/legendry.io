class CreateEntries < ActiveRecord::Migration[6.0]
  def change
    create_table :entries do |t|
      t.string :number
      t.string :title
      t.text :description
      t.belongs_to :specification, foreign_key: true

      t.timestamps
    end
  end
end
