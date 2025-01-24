# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::Orders::CreateOrder, type: :request do
  describe "#resolve" do
    let!(:customer) {create(:customer)}
    let!(:product_one) { create(:product)}
    let!(:product_two) { create(:product)}
    let(:query) {
      <<~GQL
        mutation($customerId: ID!, $products: [OrderProductInput!]){
          createOrder(input: {customerId: $customerId, products: $products}){
            order {
              id 
              customer {
                id
                name
              }
              products {
                product {
                  id
                  name
                }
                price
                quantity
              }
              total
              status
            }
            errors    
          }
        } 
      GQL
    }

    it 'should return errors if customer does not exist' do
      result = NaturalezaSchema.execute(query, variables: { customer_id: -1, products: [
        {product_id: product_one.id, quantity: 1, price: 10}] })

      order = result.dig('data', 'createOrder', 'order')
      errors = result.dig('data', 'createOrder', 'errors')

      expect(order).to be_nil
      expect(errors.size).not_to eq(0)
      # TODO: we need to add the error
    end
    it 'should return errors if any product does not exist'
    it 'should create a new order'
  end
end