require 'rails_helper'

RSpec.describe User, type: :model do

  describe "validations" do

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

    context "passwordが存在している場合" do
      let!(:user) { FactoryBot.build(:user, password: "hogehoge") }

      it "Userが作成されること" do
        expect(user).to be_valid
      end
    end

    context "passwordが存在しない場合" do
      let!(:user) { FactoryBot.build(:user, password: nil) }

      it "Userが作成されないこと" do
        expect(user).to be_invalid
      end
    end

    context "passwordの長さが6文字未満の場合" do
      let!(:user) { FactoryBot.build(:user, password: "12345") }

      it "Userが作成されないこと" do
        expect(user).to be_invalid
      end
    end

    context "passwordの長さが12文字より多い場合" do
      let!(:user) { FactoryBot.build(:user, password: "1234567890123") }

      it "Userが作成されないこと" do
        expect(user).to be_invalid
      end
    end
  end
end
