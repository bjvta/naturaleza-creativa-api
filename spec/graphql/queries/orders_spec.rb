# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Queries Orders", type: :request do
  let!(:orders) { create_list(:order, 3) }
  let(:query) {
    <<~GQL
      query {
        orders {
          id
          status
          total
          deliverer
          customer {
            name
          }
        }
      }
    GQL
  }

  it 'should return all orders' do
    result = NaturalezaSchema.execute(query)

    orders = result.dig('data', 'orders')
    expect(orders.size).to eq(3)
  end
end
