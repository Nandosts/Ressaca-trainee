class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.string :cep
      t.string :address
      t.references :user, nil: false, foreign_key: true

      t.timestamps
    end
  end
end
