# frozen_string_literal: true

module Types
  module InputObjects
    class OrderProductInput < Types::BaseInputObject
      description "InputObject for adding products in an order"

      argument :product_id, ID, required: true
      argument :quantity, Integer, required: true
      argument :price, Float, required: true
    end
  end
end