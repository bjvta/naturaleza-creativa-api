module Types
  module Objects
    class CustomerType < Types::BaseObject
      field :id, ID, null: false
      field :name, String, null: false
      field :phone, String, null: true
      field :address, String, null: true
    end
  end
end