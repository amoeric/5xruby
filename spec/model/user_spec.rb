require 'spec_helper'

RSpec.describe User, type: :model do
  describe do 
    let(:user){ User.new( email: 'amoeric@example.com', password: "123456" ) }

    before do
      user
    end
    
    after do
      User.destroy_all
    end
    
    context "email驗證" do
      it "@沒字不給過" do
        user.email = "@example.com"
        user.valid?
        expect(user.errors[:email]).to include "是無效的"
      end
  
      it "@前面需一個字以上" do
        user.email = "1@example.com"
        user.valid?
        expect(user).to be_valid
      end
  
      it "@後面需加網站名" do
        #@後面需加.com
        user.email = "a1234567890@"
        user.valid?
        expect(user.errors[:email]).to include "是無效的"
      end

      it "@後面需加網站名" do
        user.email = "a1234567890@example"
        user.valid?
        expect(user.errors[:email]).to include "是無效的"
      end

      it "@後面網站後加上.com" do
        user.email = "a1234567890@example"
        user.valid?
        expect(user.errors[:email]).to include "是無效的"
      end

      it "合法範圍，給過" do
        user.email = "amoeric@example.com"
        user.valid?
        expect(user).to be_valid
      end

      it "相同email不能註冊" do
        user.save
        user2 = User.create( email: "amoeric@example.com", password: "123456" )
        expect(user2).to_not be_valid
      end
  
      it "帳號驗證，相同帳號不能註冊，出現設定的錯誤訊息" do
        user.save
        user2 = User.create( email: "amoeric@example.com", password: "123456" )
        expect(user2.errors.messages[:email]).to include "這帳號已經有人使用囉"
      end
    end
    
    context "密碼驗證" do
      it "長度在六以下不給過" do
        user.password = "12345"
        user.valid?
        expect(user.errors[:password]).to include "過短（最短是 6 個字）" 
      end

      it "長度在15以上不給過" do
        user.password = "1234567890123456"
        user.valid?
        expect(user.errors[:password]).to include "過長（最長是 15 個字）"
      end

      it "在6~15內，給過" do
        user.password = "123456"
        user.valid?
        expect(user).to be_valid
      end
    end
    
    context "其他" do
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
end