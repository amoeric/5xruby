class MissionsController < ApplicationController
    before_action :find_user, only: [:index, :show, :edit]
    before_action :find_mission, only: [:destroy, :update, :edit]
  def index
    @missions = @user.missions.limit(10)
  end

  def new
    @mission = Mission.new
  end

  def show
    @mission = @user.missions.find(params[:id])
  end

  def create
    @mission = Mission.new(params_mission)
    if @mission.save
      redirect_to user_missions_path(params[:user_id]), notice: '新增任務成功！'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @mission.update(params_mission)
      redirect_to user_missions_path(params[:user_id]), notice: "修改成功！"
    else
      render :edit
    end
  end

  def destroy
    if @mission.destroy
      redirect_to user_missions_path(params[:user_id]), notice: "刪除成功！"
    else
      render :index
    end
  end

  private
  def params_mission
    params.require(:mission).permit(:name, :content, :user_id, :start_time, :end_time)
  end

  def find_user
    @user = User.find(params[:user_id])
  end

  def find_mission
    @mission = Mission.find(params[:id])
  end
end
