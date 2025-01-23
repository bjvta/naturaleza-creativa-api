# frozen_string_literal: true

module Mutations
  module Products
    class CreateProduct < Mutations::BaseMutation
      description "Create a new product"

      argument :name, String, required: true
      argument :default_price, Float, required: true
      argument :unit, String, required: false

      field :product, Types::Objects::ProductType, null: true
      field :errors, [String], null: false

      def resolve(name:, default_price:, unit: nil)
        product = Product.new(name: name, default_price: default_price, unit: unit)
        if product.save
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
      end

    end
  end
end