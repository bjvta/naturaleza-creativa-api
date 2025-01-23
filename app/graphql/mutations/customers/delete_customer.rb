# frozen_string_literal: true

module Mutations
  module Customers
    class DeleteCustomer < Mutations::BaseMutation
      description "Delete a customer"

      argument :id, ID, required: true

      type Types::Objects::CustomerType
      field :result, Boolean, null: false
      field :message, String, null: false

      def resolve(id:)
        customer = Customer.find_by!(id: id)
        customer.destroy!
        { result: true,
          message: "Customer deleted!"
        }
      rescue ActiveRecord::RecordNotFound => e
        { result: false,
          message: e.message
        }
      end
    end
  end
end