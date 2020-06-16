class CreateDrinkTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :drink_types do |t|
      t.string :name
      t.boolean :alcoholic?

      t.timestamps
    end
  end
end
