class Admin::PagesController < ApplicationController
  include SessionHelper
  before_action :admin?

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