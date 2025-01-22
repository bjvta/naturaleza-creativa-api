require 'rails_helper'

RSpec.describe Order, type: :model do
  describe "Validation" do
    it { should validate_presence_of(:total) }
    it { should belong_to(:customer) }
    it { should have_many(:order_products) }
  end
end
