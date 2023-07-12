# Including the necessary files for testing in a Rails application
require 'rails_helper'

RSpec.describe Show, type: :model do
  # Test for factory testing
  context "testando factory" do
    # Test case: Verifying if a new instance of the "Show" model created with FactoryBot is valid
    it { expect(FactoryBot.build(:show)).to be_valid }
  end

  # Test for validating "Show"
  context "validar show" do
    # Test case: Checking if a new instance of the "Show" model with a nil name attribute is invalid
    it "deve ser valido se show:nil" do
      expect(FactoryBot.build(:show, name: nil)).to be_invalid
    end
  end
end
