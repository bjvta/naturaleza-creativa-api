class Product < ApplicationRecord
  validates :name, :default_price, presence: true
  validates :default_price, numericality: { greater_than: 0 }

  has_many :order_products
  has_many :orders, through: :order_products
end
