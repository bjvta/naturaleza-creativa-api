class Product < ApplicationRecord
  validates :name, :default_price, presence: true
end
