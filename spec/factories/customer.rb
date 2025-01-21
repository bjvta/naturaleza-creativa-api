FactoryBot.define do
  factory :customer do
    name { Faker::Name.name }
    phone { Faker::PhoneNumber.cell_phone }
    address { Faker::Address.full_address }
  end
end
