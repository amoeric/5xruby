class TagsController < ApplicationController

  def index
    find_user
    @q = @user.missions.ransack(params[:q])
    @tags = Tag.page(params[:page]).per(30)
  end

  def new
    @tag = Tag.new
  end
  
  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      if params[:mission_id]
        redirect_to user_mission_path(params[:user_id], params[:mission_id])
      else
        redirect_to new_user_mission_path(params[:user_id])
      end
    else
      render :new 
    end
  end

  def destroy
    find_tag
    if @tag.destroy
      if params[:mission_id]
        redirect_to user_mission_path(params[:user_id], params[:mission_id])
      else
        redirect_to user_tags_path(params[:user_id])
      end
    end
  end

  private
  def tag_params
    params.require(:tag).permit(:category, mission_ids:[])
  end

  def find_user
    @user = User.find(params[:user_id])
  end

  def find_tag
    @tag = Tag.find(params[:id])
  end
end