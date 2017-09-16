class Product < ApplicationRecord
  has_many :orders, through: :product_orders
  has_many :product_orders, dependent: :destroy
  belongs_to :category

  validates :category, presence: true
  validates :name, presence: true
end
