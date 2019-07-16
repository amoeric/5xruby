require 'spec_helper'

RSpec.describe Mission, type: :model do
  before(:each)do
    @user = User.find_by(account: "amoeric")
    if @user.nil?
      @user = User.create( account: "amoeric", password: "123456" )
    end
  end
  describe do 
    it "user_id必須存在,belons_to" do
      mission = Mission.create( title: "18person", content:"5xruby")
      expect(mission.errors[:user]).to eq ["必須存在"]
    end

    it "title不得為空" do
      mission = Mission.create( content:"5xruby", user_id: @user.id )
      expect(mission.errors[:title]).to eq ["不能為空白"]
    end
    
    it "content為空也給過" do
      mission = Mission.create( title: "18person", user_id: @user.id )
      expect(mission).to be_valid
    end
    
    it "priority是否有預設值" do
      mission = Mission.create( title: "18person", user_id: @user.id )
      expect(mission.priority).to eq "low"
    end

    it "priority的enum是否有效" do
      mission = Mission.create( title: "18person", user_id: @user.id, priority: 2 )
      expect(mission.priority).to eq "hight"
    end

    it "status是否有預設值" do
      mission = Mission.create( title: "18person", user_id: @user.id )
      expect(mission.status).to eq "waiting"
    end

    it "status的enum是否有效" do
      mission = Mission.create( title: "18person", user_id: @user.id, status: 2 )
      expect(mission.status).to eq "finished"
    end

    it "mission的結束時間不能比開始時間早" do
      mission = Mission.create( title: "18person", user_id: @user.id, end_time: "2020-05-19 10:30:00", start_time: "2020-05-19 11:30:00" )
      expect(mission.errors[:end_time]).to eq ["結束日期不能比開始日期早哦！"]
    end
  end
end