# Including the necessary files for testing in a Rails application
require 'rails_helper'

RSpec.describe Tag, type: :model do
  # Test for factory testing
  context "testando factory" do
    # Test case: Verifying if a new instance of the "Tag" model created with FactoryBot is valid
    it { expect(FactoryBot.build(:tag)).to be_valid }
  end

  # Test for validating "Tag"
  context "validar tag" do
    # Test case: Checking if a new instance of the "Tag" model with a nil name attribute is invalid
    it "deve ser valido se tag:nil" do
      expect(FactoryBot.build(:tag, name: nil)).to be_invalid
    end
  end
end
