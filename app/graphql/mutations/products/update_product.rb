# frozen_string_literal: true

module Mutations
  module Products
    class UpdateProduct < Mutations::BaseMutation
      description "Update a product"

      argument :id, ID, required: true
      argument :name, String, required: false
      argument :default_price, Float, required: false
      argument :unit, String, required: false

      field :product, Types::Objects::ProductType, null: true
      field :errors, [String], null: true

      def resolve(id: , name: nil, default_price: nil, unit: nil)
        product = Product.find_by!(id: id)

        if product.update(name: name, default_price: default_price, unit: unit)
          {
            product: product,
            errors: []
          }
        else
          {
            product: nil,
            errors: product.errors.full_messages
          }
        end
      rescue ActiveRecord::RecordNotFound => e
        {
          product: nil,
          errors: [e.message]
        }
      end
    end
  end
end
