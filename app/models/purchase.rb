class Purchase < ApplicationRecord
  belongs_to :user
  has_many :purchase_products
  has_many :products, through: :purchase_products
end
