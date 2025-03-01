# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Product, type: :model do
  describe "Validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:default_price)}
    it { should validate_numericality_of(:default_price).is_greater_than(0) }
  end
end
