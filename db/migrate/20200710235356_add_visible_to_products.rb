class AddVisibleToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :visible, :boolean
  end
end
