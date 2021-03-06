class SessionsController < ApplicationController
  include SessionHelper
  before_action :user_sign_in?, only: :new
  layout 'login', only: [:new]

  def new
  end

  def create
    user = User.find_by( email: params[:session][:email] )
    if user && user.authenticate( params[:session][:password] )
      #session[:user_id]
      login(user)
      redirect_to missions_path, notice: I18n.t("notice.login_success")
    else
      flash[:notice] = I18n.t("notice.login_error")
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: I18n.t("notice.logout_success")
  end
end
