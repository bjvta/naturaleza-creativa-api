module Types
  module Objects
    class ProductType < Types::BaseObject
      field :id, ID, null: false
      field :name, String, null: false
      field :default_price, Float, null: false
      field :unit, String, null: true
    end
  end
end