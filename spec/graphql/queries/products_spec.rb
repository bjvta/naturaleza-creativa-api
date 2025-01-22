# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Query Products', type: :request do
  let!(:products) { create_list(:product, 3) }

  it 'fetches all products' do
    query = <<-GQL
      query {
        products {
          id
          name
          defaultPrice
          unit
        } 
      } 
    GQL

    post '/graphql', params: { query: query}
    result = JSON.parse(response.body)

    expect(response).to have_http_status(:success)
    expect(result['data']['products'].size).to eq(3)
  end
end