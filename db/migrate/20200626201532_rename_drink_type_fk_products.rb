class RenameDrinkTypeFkProducts < ActiveRecord::Migration[5.2]
  def change
    rename_column :products, :drink_types_id, :drink_type_id
  end
end
