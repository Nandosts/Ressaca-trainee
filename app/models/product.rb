class Product < ApplicationRecord
  belongs_to :drink_type
  validate :name, presence: true
  validate :value, presence: true
  validate :quantity, presence: true
  validate :volume, presence: true
  has_one_attached :photo
end
