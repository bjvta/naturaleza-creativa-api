module Mutations
  module Customers
    class CreateCustomer < BaseMutation
      description "Creates a new customer"

      argument :name, String, required: true
      argument :phone, String, required: false
      argument :address, String, required: false

      field :customer, Types::Objects::CustomerType, null: true
      field :errors, [String], null: true

      def resolve(name:, phone: nil, address: nil)
        customer = Customer.new(name: name, phone: phone, address: address)
        if customer.save
          {
            customer: customer,
            errors: []
          }
        else
          {
            customer: nil,
            errors: customer.errors.full_messages
          }
        end
      end
    end
  end
end
