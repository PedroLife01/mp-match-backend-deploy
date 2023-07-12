# Including the necessary files for testing in a Rails application
require 'rails_helper'

RSpec.describe Movie, type: :model do
  # Test for factory testing
  context "testando factory" do
    # Test case: Verifying if a new instance of the "Movie" model created with FactoryBot is valid
    it { expect(FactoryBot.build(:movie)).to be_valid }
  end

  # Test for validating "Movie"
  context "validar movie" do
    # Test case: Checking if a new instance of the "Movie" model with a nil name attribute is invalid
    it "deve ser valido se movie:nil" do
      expect(FactoryBot.build(:movie, name: nil)).to be_invalid
    end
  end
end
