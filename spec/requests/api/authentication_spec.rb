require 'rails_helper'

RSpec.describe "Api::Authentications", type: :request do
  describe "POST /auth/login" do
    PSWD = "123456"
    let(:user) { FactoryBot.create(:user, password: PSWD) }

    context "good POST" do
      it "returns 200 OK" do
        post "/api/auth/login", params: {email: user.email, password: PSWD }
        expect(response).to have_http_status(:ok)
      end
    end

    context "bad POST" do
      it "returns 401 UNAUTHORIZED (no password)" do
        post "/api/auth/login", params: {email: user.email, password: nil }
        expect(response).to have_http_status(:unauthorized)
      end

      it "returns 401 UNAUTHORIZED (no email)" do
        post "/api/auth/login", params: {email: nil, password: PSWD }
        expect(response).to have_http_status(:unauthorized)
      end
    end

  end
end
