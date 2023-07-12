# Including the necessary files for testing in a Rails application
require 'rails_helper'

RSpec.describe Book, type: :model do
  # Test for factory testing
  context "testando factory" do
    # Test case: Verifying if a new instance of the "Book" model created with FactoryBot is valid
    it { expect(FactoryBot.build(:book)).to be_valid }
  end

  # Test for validating "Book"
  context "validar book" do
    # Test case: Checking if a new instance of the "Book" model with a nil name attribute is invalid
    it "deve ser valido se book:nil" do
      expect(FactoryBot.build(:book, name: nil)).to be_invalid
    end
  end
end
