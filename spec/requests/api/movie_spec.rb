require 'rails_helper'

RSpec.describe "Api::movies", type: :request do
  
  describe "POST /movie" do
    let(:user) do 
      FactoryBot.create(:user, is_admin: true)
    end
    let(:movie_params) do 
      FactoryBot.attributes_for(:movie)
    end

    context "good POST" do
      it "returns 201 CREATED" do
        token = JsonWebToken.encode(user_id: user.id)
        post "/api/movie", params:{() => movie_params}, headers: {"Authorization" => token}
        expect(response).to have_http_status(:created)
      end
    end

    context "bad params" do
      it "returns 400 BAD REQUEST" do
        token = JsonWebToken.encode(user_id: user.id)
        post "/api/movie", params:{name: nil}, headers: {"Authorization" => token}
        expect(response).to have_http_status(:bad_request)
      end
    end
  end


  describe "DELETE /movie/:id" do
    let(:user) do 
      FactoryBot.create(:user, is_admin: true)
    end
    let(:movie) { FactoryBot.create(:movie) }

    context "good DELETE" do
      it "returns 204 NO CONTENT" do
        token = JsonWebToken.encode(user_id: user.id)
        delete "/api/movie/#{movie.id}", headers: {"Authorization" => token}
        expect(response).to have_http_status(:no_content)
      end
    end
  end

end
