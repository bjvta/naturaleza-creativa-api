# frozen_string_literal: true

module Mutations
  module Orders
    class CreateOrder < Mutations::BaseMutation
      description "Create a new order"

      argument :customer_id, ID, required: true
      argument :products, [Types::InputObjects::OrderProductInput], required: true

      field :order, Types::Objects::OrderType, null: true
      field :errors, [String], null: false

      def resolve(customer_id:, products:)
        customer = Customer.find_by!(id: customer_id)

        total = products.sum { |p| p[:price] }

        order = Order.new
        order.customer = customer
        order.total = total
        order.status = 'created'

        order.save!

        products.each do |product|
          product = Product.find_by!(id: product[:id])

          order_product = OrderProduct.new

          order_product.order = order
          order_product.product = product
          order_product.quantity = product[:quantity]
          order_product.price = product[:price]

          order_product.save!
        end
        order.reload

        {
          order: order,
          errors: []
        }
      rescue ActiveRecord::RecordNotFound => e
        {
          order: nil,
          errors: [e.message]
        }
      end
    end
  end
end