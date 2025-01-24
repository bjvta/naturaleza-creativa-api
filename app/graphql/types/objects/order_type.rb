# frozen_string_literal: true

module Types
  module Objects
    class OrderType < Types::BaseObject
      field :id, ID, null: false
      field :status, String, null: true
      field :deliverer, String, null: true
      field :total, Float, null: true
      field :customer, Types::Objects::CustomerType, null: false
      # field :order_products, [Types::Objects::OrderProduct], null: false
    end
  end
end
