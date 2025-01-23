# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::Products::CreateProduct, type: :request do
  describe '#resolve' do
    let(:query) do
      <<~GQL
        mutation($name: String!, $defaultPrice: Float!, $unit: String) {
          createProduct(input: { name: $name, defaultPrice: $defaultPrice, unit: $unit }) {
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
    end

    it 'creates a product' do
      result = NaturalezaSchema.execute(query, variables: { name: 'Test Product', defaultPrice: 100.0, unit: 'kg' })

      product = result.dig('data', 'createProduct', 'product')
      errors = result.dig('data', 'createProduct', 'errors')

      expect(product).to include('name' => 'Test Product', 'defaultPrice' => 100.0, 'unit' => 'kg')
      expect(errors).to be_empty
    end

    it 'returns errors for invalid input' do
      result = NaturalezaSchema.execute(query, variables: { name: '', defaultPrice: -10.0, unit: 'kg' })

      product = result.dig('data', 'createProduct', 'product')
      errors = result.dig('data', 'createProduct', 'errors')

      expect(product).to be_nil
      expect(errors).to include("Name can't be blank", "Default price must be greater than 0")
    end
  end
end
