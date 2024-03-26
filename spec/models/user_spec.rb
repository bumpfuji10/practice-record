require 'rails_helper'

RSpec.describe User, type: :model do

  describe "validation" do

    context "nameとemailが存在する場合" do
      let!(:user) { FactoryBot.create(:user, name: "Yo Kamada", email: "test@test.com") }

      it "Userが作成されること" do
        expect(user).to be_valid
      end
    end

    context "nameが存在しない場合" do
      let!(:user) { FactoryBot.build(:user, name: nil, email: nil) }

      it "Userが作成されないこと" do
        expect(user).to be_invalid
      end
    end

    context "emailが正規表現に則っている場合" do
      let!(:user) { FactoryBot.build(:user, email: "test@mail.com") }

      it "Userが作成されること" do
        expect(user).to be_valid
      end
    end

    context "emailが正規表現に則っていない場合" do
      let!(:user) { FactoryBot.build(:user, email: "test@mail") }

      it "Userが作成されないこと" do
        expect(user).to be_invalid
      end
    end
  end
end
