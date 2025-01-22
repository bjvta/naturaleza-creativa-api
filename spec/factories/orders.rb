FactoryBot.define do
  factory :order do
    customer
    total { Faker::Number.decimal(l_digits: 2) }
    status { "created" }
    deliverer { nil }
    delivery_cost { 0.00 }
  end
end
