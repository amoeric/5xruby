class ApplicationController < ActionController::Base
  include SessionHelper
  before_action :current_user
  
end
