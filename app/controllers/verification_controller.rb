class VerificationController < ApplicationController
  include SessionHelper
  before_action :current_user
end