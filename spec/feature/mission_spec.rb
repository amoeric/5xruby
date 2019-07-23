require 'spec_helper'

RSpec.describe Mission, type: :model do
  let(:user) do
    login_user = User.find_by(account: "amoeric")
    login_user = User.create( account: "amoeric", password: "123456" ) if login_user.nil?
    login_user
  end
  
  let(:reset!) do
    User.destroy_all
    Mission.destroy_all
  end

  describe "mission model 測試" do 
    let(:mission) do
      Mission.new( title: "18person", user_id: user.id )  
    end

    it "user_id必須存在,belons_to" do
      mission = Mission.create( title: "18person", content:"5xruby")
      expect(mission.errors[:user]).to eq ["必須存在"]
    end

    it "title不得為空" do
      mission_notitle = Mission.create( content:"5xruby", user_id: user.id )
      expect(mission_notitle.errors[:title]).to eq ["不能為空白"]
    end
    
    it "content為空也給過" do
      expect(mission).to be_valid
    end
    
    context "enum測試" do
      it "priority是否有預設值" do
        expect(mission.priority).to eq "low"
      end
  
      it "priority的enum是否有效" do
        mission.priority = 2
        expect(mission.priority).to eq "hight"
      end
  
      it "status是否有預設值" do
        expect(mission.status).to eq "waiting"
      end
  
      it "status的enum是否有效" do
        mission.status = 2
        expect(mission.status).to eq "finished"
      end
    end

    it "mission的結束時間不能比開始時間早" do
      mission.end_time = "2020-05-19 10:30:00"
      mission.start_time = "2020-05-19 11:30:00"
      mission.save
      expect(mission.errors[:end_time]).to eq ["結束日期不能比開始日期早哦！"]
    end

    context "搜尋" do
      let(:missions) do
        Mission.create( title: "18person", content:"5xruby", user_id: user.id, status: 1, start_time: "2020-04-19 10:30", end_time: "2020-04-19 11:30" )
        Mission.create( title: "18person", content:"ericisme", user_id: user.id, status: 1, start_time: "2020-04-19 10:30", end_time: "2020-04-19 11:30" )
        Mission.create( title: "hellomission", content:"5xruby", user_id: user.id, status: 2, start_time: "2020-04-19 10:30", end_time: "2020-04-19 11:30" )
      end

      before do
        missions
      end
       
      it "以標題搜尋" do
        @q = user.missions.ransack(title_cont: 'mission')
        expect(@q.result.map(&:title)).to include ("hellomission")
      end
  
      it "以狀態搜尋" do
        @q = user.missions.ransack(status_eq: 2)
        expect(@q.result.map(&:title)).to include ("hellomission")
        reset!
      end
    end
  end
end