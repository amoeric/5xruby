class TagsController < ApplicationController
  before_action :find_user, only: :index
  before_action :find_tag, only: :destroy

  def index
    @q = @user.missions.ransack(params[:q])
    @tags = Tag.page(params[:page]).per(30)
  end

  def new
    @tag = Tag.new
    before_path(URI(request.referer || '').path)
  end

  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      redirect_path(session['before_path'])
    else
      render :new 
    end
  end

  def destroy
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

  def before_path(path)
    session['before_path'] = path unless path.nil?
  end

  def redirect_path(session_path)
    path = session_path.split('/')
    if path.last == 'edit'
      #mission-edit
      redirect_to edit_user_mission_path(params[:user_id], path[4])
    else
      #mission-new
      redirect_to new_user_mission_path(params[:user_id])
    end
  end
end