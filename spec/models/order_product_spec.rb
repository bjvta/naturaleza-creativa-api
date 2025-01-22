require 'rails_helper'

RSpec.describe OrderProduct, type: :model do
  describe "Validations" do
    it { should validate_presence_of(:quantity) }
    it { should validate_presence_of(:price) }
    it { should belong_to(:order) }
    it { should belong_to(:product) }
  end
end
