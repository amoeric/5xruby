require 'spec_helper'
require 'date'

feature "任務管理系統" do
  scenario "可新增自己的任務" do
    create_user(account: 'zxc123', password: '123456')
    expect(page).to have_content "zxc123"
    create_user(account: 'eric', password: '123456')
    expect(page).to have_content "eric"
    user_login(account:'zxc123')
    expect(page).to have_content I18n.t("back.new_mission")
    create_mission(title: '任務二', content: '五倍紅寶石', start_time: "2020-04-19 10:30", end_time: "2020-04-19 11:30")
    expect(page).to have_content "任務二"
    expect(page).to have_content "五倍紅寶石"
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
    page.first('div.mission', :text => '任務二').click_on I18n.t("mission.edit")
    expect(page).to have_content I18n.t("mission.edit")
    expect(find_field('mission[title]').value) == "任務二"
    edit_mission(title: '任務二', content: '五倍紅寶石', start_time: "2020-04-20 10:30", end_time: "2020-04-20 11:30")
    expect(page).to have_content "2020-04-20 10:30:00 +0800"
    expect(page).to have_content "2020-04-20 11:30:00 +0800"
  end

  scenario "可刪除自己的任務" do
    user_login(account:'zxc123')
    expect(page).to have_content "任務二"
    page.accept_confirm I18n.t("confirm.delete") do
      click_on I18n.t("mission.delete")
    end
    expect(page).to have_no_content "任務二"
    page.should have_css("div.mission", :count => 0)
  end

  scenario "使用者登入後，只能看見自己建立的任務" do
    user_login(account:'zxc123')
    create_mission(title: '看不到此任務', content: '五倍紅寶石', start_time: "2020-04-19 10:30", end_time: "2020-04-19 11:30")
    expect(page).to have_content "看不到此任務"
    user_login(account:'eric')
    create_mission(title: '任務一', content: '五倍紅寶石', start_time: "2020-04-19 10:30", end_time: "2020-04-19 11:30")
    expect(page).to have_content "任務一"
    page.should have_css("div.mission", :count => 1)
  end

  scenario "可依照建立時間進行排序" do
    user_login(account:'zxc123')
    create_mission(title: '任務一', content: '五倍紅寶石', start_time: "2020-04-19 10:30", end_time: "2020-04-19 11:30")
    expect(page).to have_content "任務一"
    create_mission(title: '任務二', content: '五倍紅寶石', start_time: "2020-04-19 10:30", end_time: "2020-04-19 11:30")
    expect(page).to have_content "任務二"
    user = User.find_by_account('zxc123')
    mission = Mission.where("user_id = ?", user.id)
    mission_total = Mission.where("user_id = ?",user.id).count
    #第一個mission 不是任務一  因為用了排序所以現在view是任務二在第一個
    expect(page.first('div.mission')).to have_no_content "任務一"
    expect(page.first('div.mission')).to have_content "任務二"
    #任務一、任務二、看不到此任務
    page.should have_css("div.mission", :count => 3)
    delete_user!
  end
  
  scenario "可設定任務的開始及結束時間" do
  end

  scenario "可設定任務的優先順序（高、中、低）" do
  end

  scenario "可設定任務目前的狀態（待處理、進行中、已完成）" do
  end

  scenario "可依狀態篩選任務" do
  end

  scenario "可以任務的標題、內容進行搜尋" do
  end

  scenario "可為任務加上分類標籤" do
  end

  scenario "任務列表，並可依優先順序、開始時間及結束時間等進行排序" do
  end

  def delete_user!
    User.destroy_all
  end
  
  def create_user(account: , password: )
    visit '/users'
    expect(page).to have_content I18n.t("Login page")
    click_on '新增使用者'
    expect(page).to have_content '新增使用者'
    fill_in 'user[account]', with: account
    fill_in 'user[password]', with: password
    click_on '送出'
    expect(page).to have_content account
    expect(page).to have_content '登入頁面'
  end
  
  def user_login(account: )
    visit '/users'
    expect(page).to have_content '登入頁面'
    page.first('div.user', :text => account).click_on '查看任務'
  end

  def create_mission(title: , content: , start_time: , end_time: )
    click_on '前往新增任務'
    expect(page).to have_content '返回'
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
    end
    click_on '送出'
  end

  def edit_mission(title: , content: , start_time: , end_time: )
    expect(page).to have_content '修改任務'
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
    end
    click_on '送出'
  end

  def convert_date(date_time )
    time = DateTime.parse(date_time)
    changed_time = time.strftime('%Y:%b:%d:%H:%M').split(':') #["2011", "May", "19", "10", "30", "14"]
  end

end
