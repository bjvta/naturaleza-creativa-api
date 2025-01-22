# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Customer Query", type: :request do
  let!(:customers) { create_list(:customer, 3)}

  it 'fetches all customers' do
    query = <<~GQL
      query {
        customers {
          id
          name
          phone
          address
        }
      }   
    GQL

    post '/graphql', params: { query: query }
    result = JSON.parse(response.body)

    expect(response).to have_http_status(:success)
    expect(result['data']['customers'].size).to eq(3)
  end
end