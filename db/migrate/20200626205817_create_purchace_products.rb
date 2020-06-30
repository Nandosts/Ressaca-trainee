class CreatePurchaceProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :purchace_products do |t|
      t.integer :quantity
      t.references :purchace, foreign_key: true
      t.references :product, foreign_key: true

      t.timestamps
    end
  end
end
