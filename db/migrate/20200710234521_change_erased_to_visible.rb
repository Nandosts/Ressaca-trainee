class ChangeErasedToVisible < ActiveRecord::Migration[5.2]
  def change
    rename_column :addresses, :erased, :visible
  end
end
