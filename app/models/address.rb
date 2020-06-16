class Address < ApplicationRecord
  belongs_to :user
  validate :name, presence: true
  validate :password, presence: true
  validate :email, presence: true
end
