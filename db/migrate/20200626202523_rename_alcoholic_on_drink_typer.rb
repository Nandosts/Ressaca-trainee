class RenameAlcoholicOnDrinkTyper < ActiveRecord::Migration[5.2]
  def change
    rename_column :drink_types, :alcoholic?, :alcoholic
  end
end
