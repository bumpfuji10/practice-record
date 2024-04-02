require 'rails_helper'

RSpec.describe "Api::V1::Users", type: :request do
  describe "GET /users" do
    let!(:user) { FactoryBot.create(:user, name: "Yo Kamada", email: "test@example.com", password: "password") }

    before do
      get "/api/v1/users"
    end

    it "リクエストに成功すること" do
      expect(response.status).to eq 200
    end

    # TODO: indexが改良された場合書き直すかspecを追加する必要がある。
    it "レスポンスにuserの情報が含まれること" do
      body = JSON.parse(response.body)
      expect(body).not_to be_empty
      expect(body[0]["name"]).to eq user.name
      expect(body[0]["email"]).to eq user.email
    end
  end
end
