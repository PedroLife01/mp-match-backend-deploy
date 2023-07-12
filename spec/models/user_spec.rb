# Including the necessary files for testing in a Rails application
require 'rails_helper'

RSpec.describe User, type: :model do
  # Test for factory testing
  context "testando factory" do
    # Test case: Verifying if a new instance of the "User" model created with FactoryBot is valid
    it { expect(FactoryBot.build(:user)).to be_valid }
  end

  # Test for validating "name"
  context "validar nome" do
    # Test case: Checking if a new instance of the "User" model with a nil name attribute is valid
    it "deve ser valido se name:nil" do
      expect(FactoryBot.build(:user, name: nil)).to be_invalid
    end
  end

  # Test for validating "email"
  context "validar email" do
    # Test case: Checking if a new instance of the "User" model with a nil email attribute is invalid
    it "deve ser invalido se email: nil" do
      expect(FactoryBot.build(:user, email: nil)).to be_invalid
    end
  end

  # Test for validating "password"
  context "validar senha" do
    # Test case: Checking if a new instance of the "User" model with a nil password attribute is invalid
    it "deve ser invalido se password:nil" do
      expect(FactoryBot.build(:user, password: nil)).to be_invalid
    end

    # Test case: Checking if a new instance of the "User" model with a password shorter than PASSWORD_LEN is invalid
    it "deve ser invalido se password < PASSWORD_LEN" do
      expect(FactoryBot.build(:user, password: "abcde")).to be_invalid
    end
  end
end
