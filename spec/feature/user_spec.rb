require 'spec_helper'

RSpec.describe User, type: :model do
  describe do 
    let(:user){ User.new( account: "a123", password: "123456" ) }

    before do
      user
    end
    
    after do
      User.destroy_all
    end

    it "帳號驗證，長度需在4~10字元" do
      #4字元以下
      user.account = "bla"
      user.valid?
      expect(user.errors[:account]).to include "過短（最短是 4 個字）"
      #10字元以上
      user.account = "a1234567890"
      user.valid?
      expect(user.errors[:account]).to include "過長（最長是 10 個字）"
      #合法範圍，4~10
      user.account = "a123"
      user.valid?
      expect(user).to be_valid
    end

    it "帳號驗證，相同帳號不能註冊" do
      user.save
      user2 = User.create( account: "a123", password: "123456" )
      expect(user2).to_not be_valid
    end

    it "帳號驗證，相同帳號不能註冊，出現設定的錯誤訊息" do
      user.save
      user2 = User.create( account: "a123", password: "123456" )
      expect(user2.errors.messages[:account]).to include "這帳號已經有人使用囉"
    end
    
    it "密碼驗證，長度需在6~15字元" do
      #4字元以下
      user.password = "12345"
      user.valid?
      expect(user.errors[:password]).to include "過短（最短是 6 個字）" 
      #10字元以上
      user.password = "1234567890123456"
      user.valid?
      expect(user.errors[:password]).to include "過長（最長是 15 個字）"
      #合法範圍，4~10
      user.password = "123456"
      user.valid?
      expect(user).to be_valid
    end

    it "role的default是否存在" do
      user.save
      expect(user.role).to eq "user"
    end

    it "role的enum是否有作用" do
      user.role = 1
      expect(user.role).to eq "admin"
    end

    it "has_many missions" do
      user.save
      mission = Mission.create( title: "18person", user: user )
      expect(user.missions).to include(mission)
    end
  end
end