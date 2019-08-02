module SessionHelper
  def login(user)
    session[:user_id] = user.id
  end

  def current_user
    if session[:user_id]
      @user ||= User.find(session[:user_id])
    end
  end

  def user_signed_in?
    !session[:user_id].nil?
  end

  def authenticate_user!
    redirect_to root_path, notice: I18n.t("notice.login_first") if @user.blank?
  end
end
