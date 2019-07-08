class MissionController < ApplicationController
    def index
        @missions = Mission.all
    end
    def new
        @mission = Mission.new
    end
    def create
        @mission = Mission.new(params_mission)
        if @mission.save
            redirect_to root_path,notice:'新增任務成功！'
        else
            render :new
        end
    end
    def edit
        @mission = Mission.find_by(id: params[:id])
        # byebug
    end
    def update
        @mission = Mission.find_by(id: params[:id])
        if @mission.update(params_mission)
            redirect_to root_path, notice: "修改成功！"
        else
            render :edit
        end
    end
    def destroy
        @mission = Mission.find_by(id: params[:id])
        if @mission.destroy
            redirect_to root_path,notice: "刪除成功"
        else
            render :index
        end

    end

    private
    def params_mission
        params.require(:mission).permit(:name, :content)
    end
end
