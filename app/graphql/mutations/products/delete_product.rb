# frozen_string_literal: true

module Mutations
  module Products
    class DeleteProduct < Mutations::BaseMutation
      description "delete a product"

      argument :id, ID, required: true

      field :result, Boolean, null: false
      field :errors, [String], null: true

      def resolve(id: )
        product = Product.find_by!(id: id)
        product.destroy!
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
