# frozen_string_literal: true

module Types
  module Objects
    class OrderProductType < Types::BaseObject
      field :product, Types::Objects::ProductType, null: false
      field :quantity, Integer, null: false
      field :price, Float, null: false
    end
  end
end