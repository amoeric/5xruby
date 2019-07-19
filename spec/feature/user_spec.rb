require 'spec_helper'

RSpec.describe User, type: :model do
  describe do 
    it "帳號驗證，長度需在4~10字元" do
      #4字元以下
      user = User.new( account: "bla", password: "123456" )
      expect(user).to_not be_valid
      user.errors[:account].should include( "過短（最短是 4 個字）" )
      #10字元以上
      user = User.new( account: "a1234567890", password: "123456" )
      expect(user).to_not be_valid
      user.errors[:account].should include( "過長（最長是 10 個字）" )
      #合法範圍，4~10
      user = User.new( account: "a123", password: "123456" )
      expect(user).to be_valid
    end

    it "帳號驗證，相同帳號不能註冊" do
      User.create( account: "test3", password: "123456" )
      user = User.create( account: "test3", password: "123456" )
      user.should_not be_valid
    end

    it "帳號驗證，相同帳號不能註冊，出現設定的錯誤訊息" do
      user = User.create( account: "test3", password: "123456" )
      user.errors[:account].should include( "這帳號已經有人使用囉" )
    end
    
    it "密碼驗證，長度需在6~15字元" do
      #6字元以下
      user = User.new( account: "a123", password: "12345" )
      expect(user).to_not be_valid
      user.errors[:password].should include( "過短（最短是 6 個字）" )
      #15字元以上
      user = User.new( account: "a123", password: "1234567890123456" )
      expect(user).to_not be_valid
      user.errors[:password].should include( "過長（最長是 15 個字）" )
      #合法範圍，6~15
      user = User.new( account: "a123", password: "123456" )
      expect(user).to be_valid
    end

    it "role的default是否存在" do
      user = User.new( account: "test4", password: "123456" )
      expect(user.role).to eq "user"
    end

    it "role的enum是否有作用" do
      user = User.new( account: "test4", password: "123456", role: 1 )
      expect(user.role).to eq "admin"
    end

    it "has_many missions" do
      user = User.find_by(account: "test6")
      user = User.create( account: "test6", password: "123456", role: 1 ) if user.nil?
      mission = Mission.create( title: "18person", user_id: user.id )
      expect(user.missions).to include(mission)
    end
  end
end