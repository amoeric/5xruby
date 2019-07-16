class ApplicationController < ActionController::Base
    before_action :find_user

    private
    def find_user
      if params[:user_id].nil?
        @user = nil
      else
        @user = User.find(params[:user_id])
      end
    end
end
