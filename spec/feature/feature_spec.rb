require 'spec_helper'
require 'date'

feature "任務管理系統" do
  let(:user1){ create(:user) }
  let(:user2){ create(:user, :user2) }
  
  before do
    user1
    user2
    user_login(email:user1.email, password: user1.password)
  end

  context "使用者的新增、修改" do
    scenario "新增使用者" do
      user_logout
      click_on 'Sign Up'
      within "form" do
        fill_in 'user[email]', with: "asdf123@example.com"
        fill_in 'user[password]', with: "123456"
        fill_in 'user[password_confirmation]', with: "123456"
      end
      click_on '送出'
      expect(page).to have_content "新增使用者成功！"
      new_user = User.last
      expect(new_user.email).to eq "asdf123@example.com"
    end

    scenario "修改使用者" do
      find('.nav-list-ul').click
      click_on '我的檔案'
      expect(page).to have_content "更新會員資料"
      click_on '更新會員資料'
      before_user = User.find_by_email('123@example.com')
      within "form" do
        fill_in 'user[email]', with: "xeriok02390@example.com"
        fill_in 'user[password]', with: "123456"
        fill_in 'user[password_confirmation]', with: "123456"
        click_on '送出'
      end
      expect(page).to have_content "更新使用者成功！"
      after_user = User.find(before_user.id)
      expect(after_user.email).to eq "xeriok02390@example.com"
    end
  end

  context "任務的CRUD" do
    scenario "可新增自己的任務" do
      expect(page).to have_content "新增任務"
      create_mission(title: '任務二', content: '五倍紅寶石', start_time: "2020-04-19 10:30", end_time: "2020-04-19 11:30", status: "待處理", priority: "低")
      check_mission(title: '任務二', content: '五倍紅寶石', start_time: "2020-04-19 10:30", end_time: "2020-04-19 11:30", status: "待處理", priority: "低")
    end
  
    scenario "可查看自己的任務" do
      create_mission(title: '任務二', content: '五倍紅寶石', start_time: "2020-04-19 10:30", end_time: "2020-04-19 11:30", status: "待處理", priority: "低")
      check_mission(title: '任務二', content: '五倍紅寶石', start_time: "2020-04-19 10:30", end_time: "2020-04-19 11:30", status: "待處理", priority: "低")
      expect(page).to have_content "任務二"
      page.first('div.mission', :text => '任務二').click_on "查看任務"
      expect(page).to have_content "任務二"
      expect(page).to have_content "五倍紅寶石"
    end
  
    scenario "可修改自己的任務" do
      create_mission(title: '任務二', content: '五倍紅寶石', start_time: "2020-04-19 10:30", end_time: "2020-04-19 11:30", status: "待處理", priority: "低")
      check_mission(title: '任務二', content: '五倍紅寶石', start_time: "2020-04-19 10:30", end_time: "2020-04-19 11:30", status: "待處理", priority: "低")
      expect(page).to have_content "任務二"
      edit_mission(mission:'任務二' ,title: '任務二', content: '五倍紅寶石', start_time: "2020-04-20 10:30", end_time: "2020-04-20 11:30", status: "待處理", priority: "低", priority: "低")
      check_mission(title: '任務二', content: '五倍紅寶石', start_time: "2020-04-20 10:30", end_time: "2020-04-20 11:30", status: "待處理", priority: "低", priority: "低")
      expect(find('div.mission', :text => '任務二')).to have_content "2020-04-20 10:30:00 +0800"
      expect(find('div.mission', :text => '任務二')).to have_content "2020-04-20 11:30:00 +0800"
    end
  
    scenario "可刪除自己的任務" do
      create_mission(title: '任務二', content: '五倍紅寶石', start_time: "2020-04-19 10:30", end_time: "2020-04-19 11:30", status: "待處理", priority: "低")
      check_mission(title: '任務二', content: '五倍紅寶石', start_time: "2020-04-19 10:30", end_time: "2020-04-19 11:30", status: "待處理", priority: "低")
      expect(page).to have_content "任務二"
      before_delete_mission_count = Mission.count
      delete_mission!(mission: "任務二")
      page.should have_css("div.mission", :count => 0)
      expect(Mission.count).to eq before_delete_mission_count - 1
    end
  end
  
  context "任務權限" do
    scenario "使用者登入後，只能看見自己建立的任務" do
      create_mission(title: '看不到此任務', content: '五倍紅寶石', start_time: "2020-04-19 10:30", end_time: "2020-04-19 11:30", status: "待處理", priority: "低")
      check_mission(title: '看不到此任務', content: '五倍紅寶石', start_time: "2020-04-19 10:30", end_time: "2020-04-19 11:30", status: "待處理", priority: "低")
      expect(page).to have_content "看不到此任務"
      user_logout
      user_login(email:'amoeric@example.com' ,password: '123456')
      create_mission(title: '任務一', content: '五倍紅寶石', start_time: "2020-04-19 10:30", end_time: "2020-04-19 11:30", status: "待處理", priority: "低")
      check_mission(title: '任務一', content: '五倍紅寶石', start_time: "2020-04-19 10:30", end_time: "2020-04-19 11:30", status: "待處理", priority: "低")
      expect(page).to have_content "任務一"
      expect(page).to have_no_content "看不到此任務"
      page.should have_css("div.mission", :count => 1)
    end
  end

  context "任務各種設定、排序" do
    before do 
      create_mission(title: '任務一', content: '五倍紅寶石', start_time: "2020-04-19 10:30", end_time: "2020-04-19 11:30", status: "待處理", priority: "低")
      check_mission(title: '任務一', content: '五倍紅寶石', start_time: "2020-04-19 10:30", end_time: "2020-04-19 11:30", status: "待處理", priority: "低")
      create_mission(title: '任務二', content: '五倍紅寶石', start_time: "2020-04-19 10:30", end_time: "2020-04-21 11:30:00", status: "待處理", priority: "中")
      check_mission(title: '任務二', content: '五倍紅寶石', start_time: "2020-04-19 10:30", end_time: "2020-04-21 11:30:00", status: "待處理", priority: "中")
    end

    scenario "可依照建立時間進行排序" do
      expect(page).to have_content "任務一"
      expect(page).to have_content "任務二"
      click_on '以創建時間排序'
      #第一個mission 不是任務一  因為用了排序所以現在view是任務二在第一個
      page.should have_css("div.mission", :count => 2)
      expect(page.first('div.mission')).to have_content "任務二"
      expect(page.first('div.mission')).to have_no_content "任務一"
    end
    
    scenario "可設定任務的開始及結束時間" do
      expect(page).to have_content "以結束時間排序"
      edit_mission(mission: '任務二', title: '任務二', content: '五倍紅寶石', start_time: "2020-04-22 10:30", end_time: "2020-04-22 11:30", status: "待處理", priority: "中")
      check_mission(title: '任務二', content: '五倍紅寶石', start_time: "2020-04-22 10:30", end_time: "2020-04-22 11:30", status: "待處理", priority: "中")
      expect(page.first('div.mission', :text => "任務二")).to have_content "2020-04-22 10:30:00 +0800"
      expect(page.first('div.mission', :text => "任務二")).to have_content "2020-04-22 11:30:00 +0800"
    end

    scenario "可以依照結束時間排序" do
      click_on '以結束時間排序'
      first_mission = Mission.order(end_time: :desc).limit(10).first
      last_mission = Mission.order(end_time: :desc).limit(10).last
      expect(find("div.end_time", match: :first)).to have_content first_mission.end_time
      expect(all("div.end_time").last).to have_content last_mission.end_time
    end
    
    scenario "可以依照優先順序排序" do
      click_on '以優先權排序'
      first_mission = Mission.order(priority: :desc).limit(10).first
      last_mission = Mission.order(priority: :desc).limit(10).last
      expect(find("div.priority", match: :first)).to have_content first_mission.priority
      expect(all("div.priority").last).to have_content last_mission.priority
    end
  end

  context "可設定任務狀態（待處理、進行中、已完成）、設定任務優先權（低、中、高）" do
    scenario "建立時能設定狀態" do
      create_mission(title: '十八銅人', content: '五倍紅寶石', start_time: "2020-04-19 10:30", end_time: "2020-04-19 11:30", status: "進行中", priority: "低")
      check_mission(title: '十八銅人', content: '五倍紅寶石', start_time: "2020-04-19 10:30", end_time: "2020-04-19 11:30", status: "進行中", priority: "低")
      expect(find("div.mission", :text => "十八銅人")).to have_content enum_mission(value: "進行中")
    end

    scenario "能修改任務狀態" do
      create_mission(title: '十八銅人', content: '五倍紅寶石', start_time: "2020-04-19 10:30", end_time: "2020-04-19 11:30", status: "進行中", priority: "低")
      check_mission(title: '十八銅人', content: '五倍紅寶石', start_time: "2020-04-19 10:30", end_time: "2020-04-19 11:30", status: "進行中", priority: "低")
      edit_mission(mission: '十八銅人', title: '十八銅人', content: '五倍紅寶石', start_time: "2020-04-19 10:30", end_time: "2020-04-19 11:30", status: "已完成", priority: "低")
      check_mission(title: '十八銅人', content: '五倍紅寶石', start_time: "2020-04-19 10:30", end_time: "2020-04-19 11:30", status: "已完成", priority: "低")
      expect(find("div.mission", :text => "十八銅人")).to have_content enum_mission(value: "已完成")
    end

    scenario "建立時能設定優先權" do
      create_mission(title: '任務優先權測試', content: '五倍紅寶石', start_time: "2020-04-19 10:30", end_time: "2020-04-19 11:30", status: "進行中", priority: "中" )
      check_mission(title: '任務優先權測試', content: '五倍紅寶石', start_time: "2020-04-19 10:30", end_time: "2020-04-19 11:30", status: "進行中", priority: "中")
      expect(find("div.mission", :text => "任務優先權測試")).to have_content enum_mission(value: "中")
    end

    scenario "能修改任務優先權" do
      create_mission(title: '任務優先權測試', content: '五倍紅寶石', start_time: "2020-04-19 10:30", end_time: "2020-04-19 11:30", status: "進行中", priority: "低" )
      check_mission(title: '任務優先權測試', content: '五倍紅寶石', start_time: "2020-04-19 10:30", end_time: "2020-04-19 11:30", status: "進行中", priority: "低" )
      edit_mission(mission: '任務優先權測試', title: '任務優先權測試', content: '五倍紅寶石', start_time: "2020-04-19 10:30", end_time: "2020-04-19 11:30", status: "進行中", priority: "高" )
      check_mission(title: '任務優先權測試', content: '五倍紅寶石', start_time: "2020-04-19 10:30", end_time: "2020-04-19 11:30", status: "進行中", priority: "高")
      expect(find("div.mission", :text => "任務優先權測試")).to have_content enum_mission(value: "高")
    end
  end

  context "可以任務的標題、內容進行搜尋" do
    let(:mission_one){ create_mission(title: '十八銅人', content: '五倍紅寶石', start_time: "2020-04-19 10:30", end_time: "2020-04-19 11:30", status: "已完成", priority: "低") }
    let(:mission_two){ create_mission(title: '任務二', content: '五倍紅寶石', start_time: "2020-04-19 10:30", end_time: "2020-04-19 11:30", status: "待處理", priority: "低") }
    let(:mission_three){ create_mission(title: '任務三', content: '五倍紅寶石', start_time: "2020-04-19 10:30", end_time: "2020-04-19 11:30", status: "待處理", priority: "高") }
    before do
      mission_one
      mission_two
      mission_three
    end
    
    scenario "依標題查詢" do
      within '#title_search' do
        fill_in 'q[title_or_content_or_tags_category_cont]', with: '十八銅人'
      end
      click_on '查詢'
      expect(page.first("div.mission")).to have_content "十八銅人"
      expect(all("div.mission").last).to have_content "十八銅人"
    end

    scenario "可依狀態篩選任務" do
      within '#title_search' do
        select "已完成", :from => "q[status_eq]" 
      end
      click_on "查詢"
      expect(page.first("div.mission")).to have_content enum_mission(value: "已完成")
      expect(all("div.mission").last).to have_content enum_mission(value: "已完成")
    end

    scenario "可依優先權篩選任務" do
      within '#title_search' do
        select "高", :from => "q[priority_eq]" 
      end
      click_on "查詢"
      expect(page.first("div.mission")).to have_content enum_mission(value: "高")
      expect(all("div.mission").last).to have_content enum_mission(value: "高")
    end
  end
  
  context "標籤" do
    let(:mission_tag1){create_mission(title: '十八銅人', content: '五倍紅寶石', start_time: "2020-04-19 10:30", end_time: "2020-04-19 11:30", status: "已完成", priority: "低", tag: "my_tag")}
    
    before do
      mission_tag1
    end

    scenario "可為任務加上分類標籤" do  
      last_mission_tags = Tag.last.missions
      expect(page).to have_content last_mission_tags[0].title
    end

    scenario "可用標籤查詢" do
      within '#title_search' do
        fill_in 'q[title_or_content_or_tags_category_cont]', with: "my_tag"
      end
      click_on '查詢'
      last_mission_tags = Tag.last.missions
      expect(page).to have_content last_mission_tags[0].title
    end
  end
  
  #user相關
  def user_login(email: , password: )
    visit root_path
    within "form" do
      fill_in 'session[email]', with: email
      fill_in 'session[password]', with: password
    end
    click_on 'Log in'
  end
  
  def user_logout
    find('.nav-list-ul').click
    click_on '登出'
    expect(page).to have_content "已登出"
  end
  #mission相關
  def check_mission(title: , content: , start_time: , end_time: , status: , priority: )
    mission = Mission.last
    expect(mission.title).to eq title
    expect(mission.content).to eq content
    expect(mission.start_time).to eq Time.zone.parse(start_time)
    expect(mission.end_time).to eq Time.zone.parse(end_time)
    expect(mission.status).to eq enum_mission(value: status)
    expect(mission.priority).to eq enum_mission(value: priority)
  end

  def create_mission(title: , content: , start_time: , end_time: , status: , priority: , tag: nil)
    click_on "新增任務"
    expect(page).to have_content "任務列表"
    if tag
      click_on "新增標籤"
      within "#new_tag" do
        fill_in "tag[category]", with: tag
      end
      click_on '新增Tag'
      find(".collection_check_boxes", text: tag).click
    end
    
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
      find(".mission_status", text: "Status").find("span.radio", :text => status).click
      find(".mission_priority", text: "Priority").find("span.radio", :text => priority).click
    end
    click_on '送出'
  end

  def edit_mission(mission: , title: , content: , start_time: , end_time: , status: , priority: )
    page.first('div.mission', :text => mission).click_on "編輯任務"
    expect(find_field('mission[title]').value).to eq mission
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
      find(".mission_status", text: "Status").find("span.radio", :text => status).click
      find(".mission_priority", text: "Priority").find("span.radio", :text => priority).click
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

  def enum_mission(value: )
    case value
    when "待處理"
      "waiting"
    when "進行中"
      "conduct"
    when "已完成"
      "finished"
    when "低"
      "low"
    when "中"
      "medium"
    when "高"
      "hight"
    end
  end
end
