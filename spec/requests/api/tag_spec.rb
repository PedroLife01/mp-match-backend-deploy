require 'rails_helper'

RSpec.describe "Api::Tags", type: :request do
  
  describe "POST /tag" do
    let(:user) do 
      FactoryBot.create(:user, is_admin: true)
    end
    let(:tag_params) do 
      FactoryBot.attributes_for(:tag)
    end

    context "good POST" do
      it "returns 201 CREATED" do
        token = JsonWebToken.encode(user_id: user.id)
        post "/api/tag", params:{() => tag_params}, headers: {"Authorization" => token}
        expect(response).to have_http_status(:created)
      end
    end

    context "bad params" do
      it "returns 400 BAD REQUEST" do
        token = JsonWebToken.encode(user_id: user.id)
        post "/api/tag", params:{name: nil}, headers: {"Authorization" => token}
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  describe "DELETE /tag/:id" do
    let(:user) do 
      FactoryBot.create(:user, is_admin: true)
    end
    let(:tag) { FactoryBot.create(:tag) }

    context "good DELETE" do
      it "returns 204 NO CONTENT" do
        token = JsonWebToken.encode(user_id: user.id)
        delete "/api/tag/#{tag.id}", headers: {"Authorization" => token}
        expect(response).to have_http_status(:no_content)
      end
    end
  end

end
