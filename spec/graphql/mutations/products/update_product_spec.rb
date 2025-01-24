# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::Products::UpdateProduct, type: :request do
  describe '#resolve' do
    let!(:product) { create(:product) }
    let(:query) {
      <<~GQL
        mutation($id: ID!, $name: String, $defaultPrice: Float, $unit: String){
          updateProduct(input: {id: $id, name: $name, defaultPrice: $defaultPrice, unit: $unit}){
            product {
              id
              name
              defaultPrice
              unit
            }
            errors
          }
        }
      GQL
    }

    it "updates a product" do
      result = NaturalezaSchema.execute(query, variables: {id: product.id, name: "TestProduct", defaultPrice: 10, unit: "und"})

      product = result.dig('data', 'updateProduct', 'product')
      errors = result.dig('data', 'updateProduct', 'errors')

      expect(product).to include('name' => 'TestProduct', 'defaultPrice' => 10, 'unit' => 'und')
      expect(errors).to be_empty
    end
    it "return error when the product does not exist" do
      result = NaturalezaSchema.execute(query, variables: {id: -1, name: "TestProduct", defaultPrice: 10, unit: "und"})

      product = result.dig('data', 'updateProduct', 'product')
      errors = result.dig('data', 'updateProduct', 'errors')


      expect(product).to be_nil
      expect(errors).to include("Couldn't find Product with [WHERE \"products\".\"id\" = $1]")
    end
    it "return error for invalid input" do
      result = NaturalezaSchema.execute(query, variables: {id: product.id, name: "", defaultPrice: -10, unit: "und"})

      product = result.dig('data', 'updateProduct', 'product')
      errors = result.dig('data', 'updateProduct', 'errors')

      expect(product).to be_nil
      expect(errors).to include("Name can't be blank", "Default price must be greater than 0")
    end
  end
end
