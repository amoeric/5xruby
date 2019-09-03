class Admin::MissionsController < Admin::PagesController
  before_action :find_mission, only: [:destroy, :edit, :update]

  def index
    #分為從使用者進去跟直接進任務列表，看個人、看全部
    if params[:user_id]
      find_user
      @q = @user.missions.ransack(params[:q])
      @tags = Tag.joins(:missions).where(missions: {user_id: @user }).distinct()
    else
      @q = Mission.ransack(params[:q])
    end
    
    @missions = @q.result.page(params[:page]).per(10)
  end

  def show
    if params[:user_id]
      find_user
      @mission = @user.missions.find(params[:id])
    else
      find_mission
      @user = @mission.user
    end
  end
  
  def edit
  end

  def update
    if @mission.update(params_mission)
      re_mission_index
    else
      render :edit
    end
  end
  
  def destroy
    if @mission.destroy
      re_mission_index
    else
      render :index
    end
  end

  private
  def find_mission
    @mission = Mission.find(params[:id])
  end

  def find_user
    @user = User.find(params[:user_id])
  end
  
  def re_mission_index
    if params[:user_id]
      redirect_to admin_user_missions_path(params[:user_id]), notice: I18n.t("notice.edit_mission_success")
    else
      redirect_to admin_missions_path, notice: I18n.t("notice.edit_mission_success")
    end
  end

  def params_mission
    params.require(:mission).permit(:title, :content, :start_time, :end_time, :status, :priority )
  end
end