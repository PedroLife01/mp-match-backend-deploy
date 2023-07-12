require 'rails_helper'

RSpec.describe "Api::Books", type: :request do
  
  describe "POST /book" do
    let(:user) do 
      FactoryBot.create(:user, is_admin: true)
    end
    let(:book_params) do 
      FactoryBot.attributes_for(:book)
    end

    context "good POST" do
      it "returns 201 CREATED" do
        token = JsonWebToken.encode(user_id: user.id)
        post "/api/book", params:{() => book_params}, headers: {"Authorization" => token}
        expect(response).to have_http_status(:created)
      end
    end

    context "bad params" do
      it "returns 400 BAD REQUEST" do
        token = JsonWebToken.encode(user_id: user.id)
        post "/api/book", params:{name: nil}, headers: {"Authorization" => token}
        expect(response).to have_http_status(:bad_request)
      end
    end
  end


  describe "DELETE /book/:id" do
    let(:user) do 
      FactoryBot.create(:user, is_admin: true)
    end
    let(:book) { FactoryBot.create(:book) }

    context "good DELETE" do
      it "returns 204 NO CONTENT" do
        token = JsonWebToken.encode(user_id: user.id)
        delete "/api/book/#{book.id}", headers: {"Authorization" => token}
        expect(response).to have_http_status(:no_content)
      end
    end
  end

end
