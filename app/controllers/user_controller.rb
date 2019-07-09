class UserController < ApplicationController
  def index
    @users = User.limit(10)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params_user)
    if @user.save
        redirect_to user_index_path, notice: '新增使用者成功！'
    else
        render :new
    end
  end

  private
  def params_user
    params.require(:user).permit(:account, :password, :role)
  end
end