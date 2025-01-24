class Order < ApplicationRecord
  belongs_to :customer

  validates :total, presence: true
  has_many :order_products, dependent: :destroy
  has_many :products, through: :order_products
end
