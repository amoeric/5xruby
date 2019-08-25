class Admin::PagesController < ApplicationController
  before_action :admin?
  layout "admin/application"

  def index
  end

  private
  def admin? 
    if current_user
      redirect_to root_path, notice: I18n.t("notice.authority_not_enough") unless current_user.admin?
    else
      redirect_to root_path, notice: I18n.t("notice.login_first")
    end
  end
end