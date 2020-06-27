class Purchace < ApplicationRecord
  belongs_to :user
  has_many :purchace_products
  has_many :products, through: :purchace_products
end
