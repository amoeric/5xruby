module AdminSearchHelper
  
  def search_form_path
    if @user.blank?
      admin_missions_path
    else
      admin_user_missions_path(@user)
    end
  end
  
  def mission_show_path(mission)
    if @user.blank?
      admin_mission_path(mission)
    else
      admin_user_mission_path(@user, mission)
    end
  end

  def mission_delete_path(mission)
    if @user.blank?
      admin_mission_path(mission)
    else
      admin_user_mission_path(@user, mission)
    end
  end
end
