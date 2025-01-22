FactoryBot.define do
  factory :order_product do
    order
    product
    quantity { 1 }
    price { 9.99 }
  end
end
