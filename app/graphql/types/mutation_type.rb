# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :create_customer, mutation: Mutations::Customers::CreateCustomer
    field :update_customer, mutation: Mutations::Customers::UpdateCustomer
    field :delete_customer, mutation: Mutations::Customers::DeleteCustomer
    field :create_product, mutation: Mutations::Products::CreateProduct
    field :update_product, mutation: Mutations::Products::UpdateProduct
  end
end
