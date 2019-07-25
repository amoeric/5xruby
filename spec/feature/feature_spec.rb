require 'spec_helper'
require 'date'

feature "任務管理系統" do

  context "任務的CRUD" do
    scenario "可新增自己的任務" do
      create_user(account: 'zxc123', password: '123456')
      user1 = User.last
      expect(user1.account).to eq "zxc123"
      create_user(account: 'eric', password: '123456')
      user2 = User.last
      expect(user2.account).to eq "eric"
      expect(page).to have_content "eric"
      user_login(account:'zxc123')
      expect(page).to have_content "新增任務"
      create_mission(title: '任務二', content: '五倍紅寶石', start_time: "2020-04-19 10:30", end_time: "2020-04-19 11:30", status: "待處理")
      #透過這方法比對資料庫資料
      check_mission(title: '任務二', content: '五倍紅寶石', start_time: "2020-04-19 10:30", end_time: "2020-04-19 11:30", status: "待處理")
    end
  
    scenario "可查看自己的任務" do
      user_login(account:'zxc123')
      expect(page).to have_content "任務二"
      page.first('div.mission', :text => '任務二').click_on I18n.t("mission.check")
      expect(page).to have_content "任務二"
      expect(page).to have_content "五倍紅寶石"
    end
  
    scenario "可修改自己的任務" do
      user_login(account:'zxc123')
      expect(page).to have_content "任務二"
      edit_mission(mission:'任務二' ,title: '任務二', content: '五倍紅寶石', start_time: "2020-04-20 10:30", end_time: "2020-04-20 11:30", status: "待處理")
      check_mission(title: '任務二', content: '五倍紅寶石', start_time: "2020-04-20 10:30", end_time: "2020-04-20 11:30", status: "待處理")
      expect(find('div.mission', :text => '任務二')).to have_content "2020-04-20 10:30:00 +0800"
      expect(find('div.mission', :text => '任務二')).to have_content "2020-04-20 11:30:00 +0800"
    end
  
    scenario "可刪除自己的任務" do
      user_login(account:'zxc123')
      expect(page).to have_content "任務二"
      before_delete_mission_count = Mission.count
      delete_mission!(mission: "任務二")
      page.should have_css("div.mission", :count => 0)
      expect(Mission.count).to eq before_delete_mission_count - 1
    end
  end
  
  context "任務權限" do
    scenario "使用者登入後，只能看見自己建立的任務" do
      user_login(account:'zxc123')
      create_mission(title: '看不到此任務', content: '五倍紅寶石', start_time: "2020-04-19 10:30", end_time: "2020-04-19 11:30", status: "待處理")
      check_mission(title: '看不到此任務', content: '五倍紅寶石', start_time: "2020-04-19 10:30", end_time: "2020-04-19 11:30", status: "待處理")
      expect(page).to have_content "看不到此任務"
      user_login(account:'eric')
      create_mission(title: '任務一', content: '五倍紅寶石', start_time: "2020-04-19 10:30", end_time: "2020-04-19 11:30", status: "待處理")
      check_mission(title: '任務一', content: '五倍紅寶石', start_time: "2020-04-19 10:30", end_time: "2020-04-19 11:30", status: "待處理")
      expect(page).to have_content "任務一"
      expect(page).to have_no_content "看不到此任務"
      page.should have_css("div.mission", :count => 1)
    end
  end

  context "排序" do
    let(:login){ user_login(account:'zxc123') }
    let(:find_user) do
      user = User.find_by_account('zxc123') 
      user
    end

    before do
      login
    end

    scenario "可依照建立時間進行排序" do
      create_mission(title: '任務一', content: '五倍紅寶石', start_time: "2020-04-19 10:30", end_time: "2020-04-19 11:30", status: "待處理")
      check_mission(title: '任務一', content: '五倍紅寶石', start_time: "2020-04-19 10:30", end_time: "2020-04-19 11:30", status: "待處理")
      expect(page).to have_content "任務一"
      create_mission(title: '任務二', content: '五倍紅寶石', start_time: "2020-04-19 10:30", end_time: "2020-04-19 11:30", status: "待處理")
      check_mission(title: '任務二', content: '五倍紅寶石', start_time: "2020-04-19 10:30", end_time: "2020-04-19 11:30", status: "待處理")
      expect(page).to have_content "任務二"
      first_mission = find_user.missions.order( created_at: :desc).limit(10).first
      #第一個mission 不是任務一  因為用了排序所以現在view是任務二在第一個
      expect(first_mission.title).to eq "任務二"
      expect(page.first('div.mission')).to have_no_content "任務一"
      expect(page.first('div.mission')).to have_content "任務二"
      #任務一、任務二、看不到此任務
      page.should have_css("div.mission", :count => 3)
    end
    
    scenario "可設定任務的開始及結束時間" do
      expect(page).to have_content "修改任務"
      edit_mission(mission: '任務二', title: '任務二', content: '五倍紅寶石', start_time: "2020-04-21 10:30", end_time: "2020-04-21 11:30", status: "待處理")
      check_mission(title: '任務二', content: '五倍紅寶石', start_time: "2020-04-21 10:30", end_time: "2020-04-21 11:30", status: "待處理")
      expect(page.first('div.mission', :text => "任務二")).to have_content "2020-04-21 10:30:00 +0800"
      expect(page.first('div.mission', :text => "任務二")).to have_content "2020-04-21 11:30:00 +0800"
    end
  
    scenario "依照任務結束時間排序desc" do
      expect(page).to have_content "排序方法："
      click_on "排序方法："
      expect(page).to have_content "以最晚結束時間排序"
      click_on "以最晚結束時間排序"
      first_mission = find_user.missions.order(end_time: :desc).limit(10).first
      last_mission = find_user.missions.order(end_time: :desc).limit(10).last
      expect(first_mission.end_time).to eq Time.zone.parse("2020-04-21 11:30:00 +0800")
      expect(last_mission.end_time).to eq Time.zone.parse("2020-04-19 11:30:00 +0800")
      expect(find("div.end_time", match: :first)).to have_content "2020-04-21 11:30:00 +0800"
      expect(all("div.end_time").last).to have_content "2020-04-19 11:30:00 +0800"
    end
    
    scenario "依照任務結束時間排序asc" do
      expect(page).to have_content "排序方法："
      click_on "排序方法："
      expect(page).to have_content "以最早結束時間排序"
      click_on "以最早結束時間排序"
      first_mission = find_user.missions.order(end_time: :asc).limit(10).first
      last_mission = find_user.missions.order(end_time: :asc).limit(10).last
      expect(first_mission.end_time).to eq Time.zone.parse("2020-04-19 11:30:00 +0800")
      expect(last_mission.end_time).to eq Time.zone.parse("2020-04-21 11:30:00 +0800")
      expect(find("div.end_time", match: :first)).to have_content "2020-04-19 11:30:00 +0800"
      expect(all("div.end_time").last).to have_content "2020-04-21 11:30:00 +0800"
    end
  end

  context "可設定任務目前的狀態（待處理、進行中、已完成）" do
    let(:login){ user_login(account:'zxc123') }

    before do
      login
    end

    scenario "建立時能設定狀態" do
      create_mission(title: '十八銅人', content: '五倍紅寶石', start_time: "2020-04-19 10:30", end_time: "2020-04-19 11:30", status: "進行中")
      check_mission(title: '十八銅人', content: '五倍紅寶石', start_time: "2020-04-19 10:30", end_time: "2020-04-19 11:30", status: "進行中")
      expect(find("div.mission", :text => "十八銅人")).to have_content "進行中"
    end

    scenario "能修改任務狀態" do
      edit_mission(mission: '十八銅人', title: '十八銅人', content: '五倍紅寶石', start_time: "2020-04-19 10:30", end_time: "2020-04-19 11:30", status: "已完成")
      check_mission(title: '十八銅人', content: '五倍紅寶石', start_time: "2020-04-19 10:30", end_time: "2020-04-19 11:30", status: "已完成")
      expect(find("div.mission", :text => "十八銅人")).to have_content "已完成"
    end
  end
  
  context "查詢" do
    let(:login){ user_login(account:'zxc123') }

    before do
      login
    end

    scenario "依標題查詢" do
      search(value: '十八銅人')
      expect(page.first("div.mission")).to have_content "十八銅人"
      expect(all("div.mission").last).to have_content "十八銅人"
    end

    scenario "依狀態查詢" do
      edit_mission(mission: '十八銅人', title: '十八銅人', content: '五倍紅寶石', start_time: "2020-04-19 10:30", end_time: "2020-04-19 11:30", status: "已完成")
      check_mission(title: '十八銅人', content: '五倍紅寶石', start_time: "2020-04-19 10:30", end_time: "2020-04-19 11:30", status: "已完成")
      search(value: '已完成')
      expect(page.first("div.mission")).to have_content "已完成"
      expect(all("div.mission").last).to have_content "已完成"
      reset!
    end
  end
  
  scenario "可設定任務的優先順序（高、中、低）" do
  end

  scenario "可依狀態篩選任務" do
  end

  scenario "可以任務的標題、內容進行搜尋" do
  end

  scenario "可為任務加上分類標籤" do
  end

  scenario "任務列表，並可依優先順序、開始時間及結束時間等進行排序" do
  end
  
  #user相關
  def reset!
    User.destroy_all
    Mission.destroy_all
  end
  
  def create_user(account: , password: )
    visit '/users'
    expect(page).to have_content I18n.t("user.new")
    click_on I18n.t("user.new")
    expect(page).to have_content I18n.t("user.new")
    fill_in 'user[account]', with: account
    fill_in 'user[password]', with: password
    click_on '送出'
    expect(page).to have_content account
  end
  
  def user_login(account: )
    visit '/users'
    page.find('div.user', :text => account).click_on '查看任務'
  end
  
  #mission相關
  def check_mission(title: , content: , start_time: , end_time: , status: )
    mission = Mission.last
    expect(mission.title).to eq title
    expect(mission.content).to eq content
    expect(mission.start_time).to eq Time.zone.parse(start_time)
    expect(mission.end_time).to eq Time.zone.parse(end_time)
    expect(mission.status).to eq status
  end

  def create_mission(title: , content: , start_time: , end_time: , status: )
    click_on I18n.t("back.new_mission")
    expect(page).to have_content I18n.t("back.mission_list")
    within '#new_mission' do
      fill_in 'mission[title]', with: title
      fill_in 'mission[content]', with: content
      #start_time
      select convert_date(start_time)[0], :from => "mission[start_time(1i)]" #年
      select "四月", :from => "mission[start_time(2i)]" #月
      select convert_date(start_time)[2], :from => "mission[start_time(3i)]" #日
      select convert_date(start_time)[3], :from => "mission[start_time(4i)]" #時
      select convert_date(start_time)[4], :from => "mission[start_time(5i)]" #分
      #end_time
      select convert_date(end_time)[0], :from => "mission[end_time(1i)]" #年
      select "四月", :from => "mission[end_time(2i)]" #月
      select convert_date(end_time)[2], :from => "mission[end_time(3i)]" #日
      select convert_date(end_time)[3], :from => "mission[end_time(4i)]" #時
      select convert_date(end_time)[4], :from => "mission[end_time(5i)]" #分
      find("span.radio", :text => status).click
    end
    click_on '送出'
  end

  def edit_mission(mission: , title: , content: , start_time: , end_time: , status: )
    page.first('div.mission', :text => mission).click_on I18n.t("mission.edit")
    expect(find_field('mission[title]').value) == mission
    within 'form' do
      fill_in 'mission[title]', with: title
      fill_in 'mission[content]', with: content
      #start_time
      select convert_date(start_time)[0], :from => "mission[start_time(1i)]" #年
      select "四月", :from => "mission[start_time(2i)]" #月
      select convert_date(start_time)[2], :from => "mission[start_time(3i)]" #日
      select convert_date(start_time)[3], :from => "mission[start_time(4i)]" #時
      select convert_date(start_time)[4], :from => "mission[start_time(5i)]" #分
      #end_time
      select convert_date(end_time)[0], :from => "mission[end_time(1i)]" #年
      select "四月", :from => "mission[end_time(2i)]" #月
      select convert_date(end_time)[2], :from => "mission[end_time(3i)]" #日
      select convert_date(end_time)[3], :from => "mission[end_time(4i)]" #時
      select convert_date(end_time)[4], :from => "mission[end_time(5i)]" #分
      find("span.radio", :text => status).click
    end
    click_on '送出'
  end

  def delete_mission!(mission: )
    target = page.first('div.mission', :text => mission)
    page.accept_confirm I18n.t("confirm.delete") do
      target.click_on I18n.t("mission.delete")
    end
  end

  #其他
  def convert_date(date_time )
    time = DateTime.parse(date_time)
    changed_time = time.strftime('%Y:%b:%d:%H:%M').split(':') #["2011", "May", "19", "10", "30", "14"]
  end

  def search(value: )
    within '.search-form' do
      fill_in 'result', with: value
    end
    click_on '查詢'
  end

  def enum_mission_status(value: )
    case value
    when "待處理"
      "waiting"
    when "進行中"
      "conduct"
    when "已完成"
      "finished"
    end
  end
end
