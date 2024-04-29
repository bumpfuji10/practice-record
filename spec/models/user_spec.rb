require 'rails_helper'

RSpec.describe User, type: :model do

  describe "validations" do
    let!(:user) { FactoryBot.build(:user, name: "Yo Kamada", email: "test@example.com", password: "password") }

    describe "name" do

      context "名前がある場合" do

        it "userが有効であること" do
          expect(user).to be_valid
        end
      end

      context "名前が無い場合" do
        before do
          user.update(name: nil)
        end

        it "userが無効であること" do
          expect(user).to be_invalid
        end
      end

      context "名前が50文字以内の場合" do
        before do
          user.update(name: "a" * 50)
        end

        it "userが有効であること" do
          expect(user).to be_valid
        end
      end

      context "名前が51文字以上の場合" do
        before do
          user.update(name: "a" * 51)
        end

        it "userが無効であること" do
          expect(user).to be_invalid
        end
      end
    end

    describe "email" do

      context "メールアドレスが正規表現に則っている場合" do
        it "userが有効であること" do
          expect(user).to be_valid
        end
      end

      context "メールアドレスが正規表現に則っていない場合" do

        before do
          user.update(email: "test@example")
        end

        it "userが無効であること" do
          expect(user).to be_invalid
        end
      end

      context "メールアドレスがある場合" do
        it "userが有効であること" do
          expect(user).to be_valid
        end
      end

      context "メールアドレスが無い場合" do
        before do
          user.update(email: nil)
        end

        it "userが無効であること" do
          expect(user).to be_invalid
        end
      end

      context "メールアドレスが重複している場合" do
        let!(:other_user) { FactoryBot.create(:user, name: "Taro Tanaka", email: "test@example.com", password: "password") }
        let!(:invalid_user) { FactoryBot.build(:user, name: "Jiro Yamada", email: "test@example.com", password: "password") }

        it "other_userが無効である場合" do
          expect(invalid_user).to be_invalid
        end
      end

    end

    describe "password" do

      context "passwordが存在する場合" do

        it "userが有効であること" do
          expect(user).to be_valid
        end
      end

      context "passwordが存在しない場合" do

        before do
          user.update(password: nil)
        end

        it "userが無効であること" do
          expect(user).to be_invalid
        end
      end

      context "passwordの長さが6文字以上の場合" do
        before do
          user.update(password: "a" * 6)
        end

        it "userが有効であること" do
          expect(user).to be_valid
        end
      end

      context "passwordの長さが5文字以内の場合" do

        before do
          user.update(password: "a" * 5)
        end
        it "userが無効であること" do
          expect(user).to be_invalid
        end
      end
    end
  end

  describe "methods" do

    describe ".find_activated" do
      let!(:user) { FactoryBot.create(:user, name: "Yo Kamada", email: "test@example.com", password: "password") }
      let(:email) { user.email }

      context "ユーザーがactivateされている場合" do
        before do
          user.update(activated: true)
        end
        it "activateされたユーザーを返すこと" do
          expect(User.find_activated(email)).to eq user
        end
      end

      context "ユーザーがactivateされていない場合" do
        it "AcitveRecord::RecordNotFoundとなること" do
          expect {
            User.find_activated(email)
          }.to raise_error(ActiveRecord::RecordNotFound)
        end
      end
    end

    # TODO: email_activate?のspec
    # describe "email_activate?" do
    # end
  end
end
