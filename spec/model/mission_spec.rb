require 'spec_helper'

RSpec.describe Mission, type: :model do
  let(:user) do
    login_user = User.find_by(email: "amoeric@example.com")
    login_user = User.create( email: "amoeric@example.com", password: "123456" ) if login_user.nil?
    login_user
  end

  describe "mission model 測試" do 
    let(:mission){ Mission.new( title: "18person", user: user ) }

    before do
      mission
    end

    it "user_id必須存在,belons_to" do
      mission.user_id = nil
      mission.valid?
      expect(mission.errors[:user]).to include "必須存在"
    end

    it "title不得為空" do
      mission.title = nil
      mission.valid?
      expect(mission.errors[:title]).to include "不能為空白"
    end
    
    it "content為空也給過" do
      expect(mission).to be_valid
    end
    
    it "mission的結束時間不能比開始時間早" do
      mission.end_time = "2020-05-19 10:30:00"
      mission.start_time = "2020-05-19 11:30:00"
      mission.valid?
      expect(mission.errors[:end_time]).to include "結束日期不能比開始日期早哦！"
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

    context "搜尋" do
      let(:mission_one){ Mission.create( title: "18person", content:"5xruby", status: 1, priority: 0, user_id: user.id, start_time: "2020-04-19 10:30", end_time: "2020-04-19 11:30" ) }
      let(:mission_two){ Mission.create( title: "18person", content:"ericisme", status: 1, priority: 0, user_id: user.id, start_time: "2020-04-19 10:30", end_time: "2020-04-19 11:30" ) }
      let(:mission_three){ Mission.create( title: "hellomission", content:"5xruby", status: 2, priority: 2, user_id: user.id, start_time: "2020-04-19 10:30", end_time: "2020-04-19 11:30" ) }

      before do
        mission_one
        mission_two
        mission_three
      end
       
      it "以標題搜尋" do
        @q = user.missions.ransack(title_cont: 'mission')
        expect(@q.result).to include (mission_three)
      end
  
      it "以狀態搜尋" do
        @q = user.missions.ransack(status_eq: 2)
        expect(@q.result).to include (mission_three)
      end

      it "以優先權搜尋" do
        @q = user.missions.ransack(priority_eq: 2)
        expect(@q.result).to include (mission_three)
        reset!
      end
    end
  end
  def reset!
    User.destroy_all
    Mission.destroy_all
  end
end