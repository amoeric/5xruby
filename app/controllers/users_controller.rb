class UsersController < ApplicationController
  def index
    @users = User.limit(10)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params_user)
    if @user.save
        redirect_to users_path, notice: I18n.t("notice.new_user_success")
    else
        render :new
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      redirect_to users_path, notice: I18n.t("notice.delete_user_success")
    else
      render :index
    end
  end

  private
  def params_user
    params.require(:user).permit(:account, :password, :role)
  end
end