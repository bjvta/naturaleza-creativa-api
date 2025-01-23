## frozen_string_literal: true
#
#require 'rails_helper'
#
#RSpec.describe Mutations::Customers::CreateCustomer do
#  describe "#resolve" do
#    subject(:mutation) { described_class.new(object: {}, context: {}, field: {})}
#    let(:args) { {input: input} }
#
#    context "creates a new customer" do
#      let(:input) { { name: "Brandon", phone: "1123123", address: "This is the address" } }
#      it "returns a new customer" do
#        result = mutation.resolve(args)
#        debugger
#      end
#    end
#
#  end
#end

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "CreateCustomer Mutation", type: :request do
  it "creates a new customer" do
    name = Faker::Name.name
    query = <<-GQL
      mutation {
        createCustomer(input: {name: "#{name}", phone: "12312312", address: "This is the address"}){
           customer {
            id
            name
           }
        }
      }
    GQL

    expect {
      post '/graphql', params: { query: query }
      result = JSON.parse(response.body)

      expect(response).to have_http_status(:success)
      expect(result['data']['createCustomer']['customer']['name']).to eq(name)
    }.to change { Customer.count }.by(1)

  end
end