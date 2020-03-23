require 'test_helper'

RSpec.describe Product, type: :model do
  subject { described_class.new }

  describe '#validation', :aggregate_failures do
    it { should validate_presence_of(:rank) }
    it { should validate_presence_of(:asin) }
    it { should validate_presence_of(:category) }
    it { should validate_presence_of(:dimensions) }
  end
end
