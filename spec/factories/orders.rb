FactoryBot.define do
  factory :order do
    customer
    total { Faker::Number.decimal(l_digits: 2) }
    status { "created" }
    deliverer { nil }
    delivery_cost { 0.00 }

    after(:create) do |order|
      create_list(:order_product, 3, order: order)
    end
  end
end
