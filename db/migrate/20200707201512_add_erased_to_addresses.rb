class AddErasedToAddresses < ActiveRecord::Migration[5.2]
  def change
    add_column :addresses, :erased, :boolean
  end
end
