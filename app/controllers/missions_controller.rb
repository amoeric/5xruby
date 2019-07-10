class MissionsController < ApplicationController

  def index
    @missions = Mission.where("user_id = ?", params[:user_id]).limit(10)
  end

  def new
    @mission = Mission.new
  end

  def show
    @mission = Mission.where("user_id = ?", params[:user_id]).find(params[:id])
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
    @user = User.find(params[:user_id])
    @mission = Mission.find(params[:id])
  end

  def update
    @mission = Mission.find(params[:id])
    if @mission.update(params_mission)
      redirect_to user_missions_path(params[:user_id]), notice: "修改成功！"
    else
      render :edit
    end
  end

  def destroy
    @mission = Mission.find(params[:id])
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

end
