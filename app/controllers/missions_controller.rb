class MissionsController < ApplicationController
  before_action :find_mission, only: [:destroy, :update, :edit]

  def index
    @q = @user.missions.ransack(params[:q])
    @missions = @q.result.limit(10)
  end
  
  def show
    @mission = @user.missions.find(params[:id])
  end

  def new
    @mission = Mission.new
  end

  def create
    @mission = Mission.new(params_mission)
    if @mission.save
      redirect_to user_missions_path(params[:user_id]), notice: I18n.t("notice.new_mission_success")
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @mission.update(params_mission)
      redirect_to user_missions_path(params[:user_id]), notice: I18n.t("notice.edit_mission_success")
    else
      render :edit
    end
  end

  def destroy
    if @mission.destroy
      redirect_to user_missions_path(params[:user_id]), notice: I18n.t("notice.delete_mission_success")
    else
      render :index
    end
  end

  private
  def params_mission
    result = params.require(:mission).permit(:title, :content, :user_id, :start_time, :end_time, :status, :priority)
    result[:status] = params[:mission][:status].to_i
    result[:priority] = params[:mission][:priority].to_i
    result
  end

  def find_mission
    @mission = Mission.find(params[:id])
  end
end
