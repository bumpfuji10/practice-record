require 'rails_helper'

RSpec.describe "Api::V1::Users", type: :request do
  describe "GET api/v1/users" do
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

  describe "POST api/v1/users" do

    context "nameとemailとpasswordのパラメータをAPIに送信して" do
      let(:params) {
        {
          user: {
            name: "Yo Kamada",
            email: "test@example.com",
            password: "testexample"
          }
        }
      }

      before do
        @user_count = User.count
        post "/api/v1/users", params: params
      end

      it "201 createdが返却されること" do
        expect(response.status).to eq 201
      end

      it "Userが作成されていること" do
        expect(User.count).to eq(@user_count + 1)
      end
    end

    context "パラメータが不十分な場合" do
      let(:invalid_params) {
        {
          user: {
            name: "Yo Kamada",
            email: "test@example",
            password: "testexample"
          }
        }
      }

      before do
        @user_count = User.count
        post "/api/v1/users", params: invalid_params
      end

      it "422 unprocessable_entityとなること" do
        expect(response.status).to eq 422
      end

      it "Userモデルが作成されていないこと" do
        expect(User.count).to eq(@user_count)
      end
    end
  end
end
