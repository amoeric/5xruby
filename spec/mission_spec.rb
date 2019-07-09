require 'spec_helper'

feature "任務管理系統" do
  before do
    user_login(account:'zxc123')
  end

  scenario "可新增自己的任務" do
    expect(page).to have_content '這是任務首頁'
    create_mission(name: '任務二', content: '五倍紅寶石')
    expect(page).to have_content '任務二'
    expect(page).to have_content '五倍紅寶石'
  end

  scenario "使用者登入後，只能看見自己建立的任務" do
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

  def user_login(account: )
    visit '/'
    expect(page).to have_content '登入頁面'
    page.first('div.user-content', :text => account).click_on '查看任務'
  end

  def create_user(account: , password: )
    visit '/'
    expect(page).to have_content '登入頁面'
    click_on '新增使用者'
    expect(page).to have_content '新增使用者'
    fill_in 'user[account]', with: account
    fill_in 'user[password]', with: password
    click_on '送出'
    expect(page).to have_content '新增使用者成功！'
  end

  def create_mission(name: , content: )
    click_on '前往新增任務'
    expect(page).to have_content '返回'
    fill_in 'mission[name]', with: name
    fill_in 'mission[content]', with: content
    click_on '送出'
  end
end
