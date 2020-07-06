class AddAddressToPurchases < ActiveRecord::Migration[5.2]
  def change
    add_reference :purchases, :address, foreign_key: true
  end
end
