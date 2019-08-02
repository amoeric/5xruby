class SessionsController < ApplicationController

  def new
    redirect_to user_missions_path(current_user.id) if (user_signed_in?)
  end

  def create
    user = User.find_by( email: params[:session][:email] )
    if user && user.authenticate( params[:session][:password] )
      #session[:user_id]
      login(user)
      redirect_to user_missions_path(user), notice: "登入成功！"
    else
      flash[:notice] = "帳號密碼錯誤"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "已登出"
  end
end
