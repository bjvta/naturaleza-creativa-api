FactoryBot.define do
  factory :product do
    name { Faker::Commerce.product_name }
    default_price { Faker::Commerce.price(range: 10..100) }
    unit { ["litro", "unidad", "galón"].sample }
  end
end
