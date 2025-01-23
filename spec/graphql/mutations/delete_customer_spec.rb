# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "DeleteCustomer Mutation", type: :request do
  let!(:customer) { create(:customer)}

  it 'should return success deletion' do
    query = <<-GQL
mutation {
  deleteCustomer(input: {id: #{customer.id}}){
    result
    message
  }
}
    GQL

    expect{
      post '/graphql', params: { query: query}
      result = JSON.parse(response.body)

      expect(response).to have_http_status(:success)
      expect(result['data']['deleteCustomer']['result']).to be_truthy
    }.to change(Customer, :count).by(-1)
  end

  it 'should return error for the deletion' do
    query = <<-GQL
mutation {
  deleteCustomer(input: { id: -1}){
    result
    message
  }
}
    GQL

    post '/graphql', params: { query: query }
    result = JSON.parse(response.body)

    expect(response).to have_http_status(:success)
    expect(result['data']['deleteCustomer']['result']).to be_falsey
  end
end