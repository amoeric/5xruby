class MissionsController < ApplicationController
  include SessionHelper
  before_action :find_mission, only: [:destroy, :update, :edit]
  before_action :authenticate_user!
  
  def index
    @q = current_user.missions.ransack(params[:q])
    @missions = @q.result.page(params[:page]).per(5)
    @tags = Tag.joins(:missions).where(missions: {user_id: current_user }).distinct()
  end
  
  def show
    @q = current_user.missions.ransack(params[:q])
    
    begin 
      @mission = current_user.missions.includes(:tags).find( params[:id])
    rescue ActiveRecord::RecordNotFound
      render 'errors/404', layout: 'errors', status: 404
    end
  end

  def new
    @mission = Mission.new
  end

  def create
    @mission = current_user.missions.new(params_mission)
    if @mission.save
      redirect_to missions_path, notice: I18n.t("notice.new_mission_success")
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @mission.update(params_mission)
      redirect_to edit_mission_path(params[:id]), notice: I18n.t("notice.edit_mission_success")
    else
      render :edit
    end
  end

  def destroy
    if @mission.destroy
      redirect_to missions_path, notice: I18n.t("notice.delete_mission_success")
    else
      render :index
    end
  end

  private
  def params_mission
    params.require(:mission).permit(:title, :content, :start_time, :end_time, :status, :priority, tag_ids: [] )
  end

  def find_mission
    begin 
      @mission = current_user.missions.find( params[:id])
    rescue ActiveRecord::RecordNotFound
      render 'errors/404', layout: 'errors', status: 404
    end
  end
end
