class ApplicationController < ActionController::Base
  include SessionHelper
  before_action :find_user
  
  private
  def find_user
    if session[:user_id].nil?
      @user = nil
    else
      @user = User.find_by(id: session[:user_id])
    end
  end

  def authenticate_user!
    if !@user && session[:user_id].nil?
      redirect_to root_path, notice: "請先登入"
    end
  end
end
