# frozen_string_literal: true

module Mutations
  module Customers
    class UpdateCustomer < Mutations::BaseMutation
      description "Update a customer"

      argument :id, ID, required: true
      argument :name, String, required: false
      argument :phone, String, required: false
      argument :address, String, required: false

      field :customer, Types::Objects::CustomerType, null: true
      field :errors, [String], null: true

      def resolve(id:, name: nil, phone: nil, address: nil)
        customer = Customer.find_by!(id: id)

        if customer.update(name: name, phone: phone, address: address)
          {
            customer: customer,
            errors: nil
          }
        else
          {
            customer: nil,
            errors: customer.errors.full_messages
          }
        end
      rescue ActiveRecord::RecordNotFound => e
        {
          customer: nil,
          errors: [e.message]
        }
      end
    end
  end
end