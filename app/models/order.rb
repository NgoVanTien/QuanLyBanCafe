class Order < ApplicationRecord
  has_many :products, through: :product_orders
  has_many :product_orders, dependent: :destroy
  belongs_to :table
end
