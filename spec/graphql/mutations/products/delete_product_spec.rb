# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::Products::DeleteProduct, type: :request do
  describe '#resolve' do
    let!(:product) { create(:product) }
    let(:query) {
      <<~GQL
        mutation($id: ID!){
          deleteProduct(input: {id: $id}){
            result
            errors
          }
        }
      GQL
    }

    it 'should return error when product does not exist' do
      result = NaturalezaSchema.execute(query, variables: { id: -1 })

      result_delete = result.dig('data', 'deleteProduct', 'result')
      errors = result.dig('data', 'deleteProduct', 'errors')

      expect(result_delete).to be_falsey
      expect(errors).to include("Couldn't find Product with [WHERE \"products\".\"id\" = $1]")
    end
    it 'should delete the product successfully' do
      expect {
        result = NaturalezaSchema.execute(query, variables: {id: product.id})

        result_delete = result.dig('data', 'deleteProduct', 'result')
        errors = result.dig('data', 'deleteProduct', 'errors')

        expect(result_delete).to be_truthy
        expect(errors).to be_empty
      }.to change(Product, :count).by(-1)
    end
  end
end
