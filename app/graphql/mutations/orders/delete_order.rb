# frozen_string_literal: true

module Mutations
  module Orders
    class DeleteOrder < Mutations::BaseMutation
      description "delete an order"

      argument :id, ID, required: true

      field :result, Boolean, null: false
      field :errors, [String], null: false

      def resolve(id: )
        order = Order.find_by!(id: id)
        order.destroy!
        {
          result: true,
          errors: []
        }
      rescue ActiveRecord::RecordNotFound => e
        {
          result: false,
          errors: [e.message]
        }
      end
    end
  end
end