module EnumMissionStatusHelper
  def enum_mission_status(value: )
    case value
    when "waiting"
      "待處理"
    when "conduct"
      "進行中"
    when "finished"
      "已完成"
    when "待處理"
      "waiting"
    when "進行中"
      "conduct"
    when "已完成"
      "finished"
    end
  end
end
