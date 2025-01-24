# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::Orders::DeleteOrder, type: :request do
  describe "#resolve" do
    let!(:order) { create(:order)}
    let(:query) {
      <<~GQL
        mutation($orderId: ID!){
          deleteOrder(input: {id: $orderId}) {
            result
            errors
          }
        }
      GQL
    }

    it 'should return errors when order does not exist' do
      result = NaturalezaSchema.execute(query, variables: {orderId: -1})

      result_data = result.dig('data', 'deleteOrder', 'result')
      errors = result.dig('data', 'deleteOrder', 'errors')

      expect(result_data).to be_falsey
      expect(errors).not_to be_empty
    end
    it 'should return true when order has been deleted' do
      result = NaturalezaSchema.execute(query, variables: {orderId: order.id})

      result_data = result.dig('data', 'deleteOrder', 'result')
      errors = result.dig('data', 'deleteOrder', 'errors')

      expect(result_data).to be_truthy
      expect(errors).to be_empty
    end
  end
end
