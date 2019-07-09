require 'spec_helper'

feature "任務管理系統" do
  scenario "可新增自己的任務" do
    visit new_mission_path
    within("#newmission") do
      fill_in 'mission[name]', with: '任務一'
      fill_in 'mission[content]', with: '新增自己的任務'
    end
    click_button '送出'
    expect(page).to have_content '新增任務成功！'
    expect(page).to have_content '任務一'
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

end
