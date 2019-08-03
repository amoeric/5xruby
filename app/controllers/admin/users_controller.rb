class Admin::UsersController < ApplicationController
  before_action :find_user, only: [:edit, :update, :destroy]

  def index
    @users = User.includes(:missions).page(params[:page]).per(10)
  end

  def edit
  end

  def update
    if @user.update(params_user)
      redirect_to admin_users_path, notice: I18n.t("notice.edit_user_success")
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      @user.missions.destroy_all
      redirect_to admin_users_path, notice: I18n.t("notice.delete_user_success")
    else
      render :index
    end
  end

  private
  def params_user
    params.require(:user).permit(:email, :password, :role, :password_confirmation)
  end

  def find_user
    @user = User.find(params[:id])
  end
end