class Product < ApplicationRecord
  belongs_to :drink_type
  validates :name, presence: true
  validates :value, presence: true
  validates :quantity, presence: true
  validates :volume, presence: true
  has_one_attached :photo
  
end
