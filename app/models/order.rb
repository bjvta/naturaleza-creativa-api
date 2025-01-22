class Order < ApplicationRecord
  belongs_to :customer

  validates :total, presence: true
  has_many :order_products
end
