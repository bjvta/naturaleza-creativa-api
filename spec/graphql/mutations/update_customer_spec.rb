# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "UpdateCustomer Mutation", type: :request do
  let!(:customer) { create(:customer)}

  context 'when customer exists' do
    it "should return the updated customer" do
      query = <<GQL
mutation {
  updateCustomer(input: {
    id: "#{customer.id}", name: "Jason"  
  }){
    customer {
      id
      name
    }
    errors
  }
}
GQL
      post '/graphql', params: { query: query}
      result = JSON.parse(response.body)

      expect(response).to have_http_status(:success)
      expect(result['data']['updateCustomer']['customer']['name']).not_to eq(customer.name)
      expect(result['data']['updateCustomer']['errors']).to be_nil
    end
  end

  context 'when customer does not exist' do
    it 'should return the error message' do
      query = <<-GQL
        mutation {
          updateCustomer(input: {id: -1, name: "test"}){
            customer {
              id
              name
            }
            errors
          }
        }
    GQL

      post '/graphql', params: { query: query }
      result = JSON.parse(response.body)
      expect(response).to have_http_status(:success)
      expect(result['data']['updateCustomer']['errors'].size).to eq(1)
    end
  end
end