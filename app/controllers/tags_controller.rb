class TagsController < ApplicationController
  include SessionHelper
  before_action :find_tag, only: :destroy
  before_action :authenticate_user!
  
  def index
    @q = current_user.missions.ransack(params[:q])
    @tags = Tag.page(params[:page]).per(30)
  end

  def new
    @tag = Tag.new
    session['before_path'] = URI(request.referer || '').path
  end

  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      redirect_to root_path(current_user) if session['before_path'].blank?
      redirect_path(session['before_path'])
    else
      render :new 
    end
  end

  def destroy
    if @tag.destroy
      if params[:mission_id]
        redirect_to mission_path(params[:mission_id])
      else
        render 'missions/edit'
      end
    end
  end

  private
  def tag_params
    params.require(:tag).permit(:category)
  end

  def find_tag
    @tag = Tag.find( params[:id])
  end

  def redirect_path(session_path)
    path = session_path.split('/')
    if path.last == 'edit'
      #mission-edit
      redirect_to edit_mission_path(path[2])
    else
      #mission-new
      redirect_to new_mission_path
    end
  end
end