module Mutations
  class CreateCustomer < BaseMutation
    argument :name, String, required: true
    argument :phone, String, required: false
    argument :address, String, required: false

    type Types::CustomerType

    def resolve(name:, phone: nil, address: nil)
      Customer.create!(name: name, phone: phone, address: address)
    end
  end
end
