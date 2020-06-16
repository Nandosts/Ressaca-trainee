class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name
      t.float :value
      t.integer :volume
      t.integer :quantity
      t.boolean :favorite
      t.references :drink_types, nil: false, foreign_key: true
      t.text :description

      t.timestamps
    end
  end
end
