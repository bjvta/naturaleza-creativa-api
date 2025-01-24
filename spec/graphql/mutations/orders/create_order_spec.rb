# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::Orders::CreateOrder, type: :request do
  describe "#resolve" do
    let!(:customer) {create(:customer)}
    let!(:product_one) { create(:product)}
    let!(:product_two) { create(:product)}
    let(:query) {
      <<~GQL
        mutation($customerId: ID!, $products: [OrderProductInput!]!){
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
      result = NaturalezaSchema.execute(query, variables: { customerId: -1, products: [
        {productId: product_one.id, quantity: 1, price: 10}] })

      order = result.dig('data', 'createOrder', 'order')
      errors = result.dig('data', 'createOrder', 'errors')

      expect(order).to be_nil
      expect(errors).not_to be_empty
    end
    it 'should return errors if any product does not exist' do
      result = NaturalezaSchema.execute(query,
                                        variables: { customerId: customer.id, products: [
                                          {
                                            productId: -1,
                                            quantity: 1,
                                            price: 10
                                          }
                                        ]}
                                        )

      order = result.dig('data', 'createOrder', 'order')
      errors = result.dig('data', 'createOrder', 'errors')

      expect(order).to be_nil
      expect(errors).not_to be_empty
    end
    it 'should create a new order' do
      result = NaturalezaSchema.execute(query, variables: { customerId: customer.id, products: [
        {
          productId: product_one.id,
          quantity: 1,
          price: 10
        },
        {
          productId: product_two.id,
          quantity: 2,
          price: 20
        }
      ]})

      order = result.dig('data', 'createOrder', 'order')
      products = result.dig('data', 'createOrder', 'order', 'products')
      errors = result.dig('data', 'createOrder', 'errors')

      expect(order).not_to be_nil
      expect(order["total"]).to eq(30)
      expect(products.size).to eq(2)
      expect(errors).to be_empty
    end
  end
end