class UsersController < ApplicationController
  include SessionHelper
  before_action :authenticate_user!, only: [:edit, :update]
  layout "login", only: [:new]
  
  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params_user)
    if @user.save
      login(@user)
      redirect_to missions_path, notice: I18n.t("notice.new_user_success")
    else
      render :new, layout: "login"
    end
  end

  def edit
  end
  
  def update
    if current_user.update(params_user)
      login(current_user)
      redirect_to missions_path, notice: I18n.t("notice.edit_user_success")
    else
      render :edit
    end
  end

  private
  def params_user
    params.require(:user).permit(:email, :password, :password_confirmation, :avatar)
  end
end