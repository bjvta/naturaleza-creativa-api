class Order < ApplicationRecord
  belongs_to :customer

  validates :total, presence: true
  has_many :order_products
  has_many :products, through: :order_products
end
