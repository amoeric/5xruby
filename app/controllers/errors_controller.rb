class ErrorsController < ApplicationController
  #當code 是什麼就render什麼
  layout 'errors'
  def show
    render params[:code], status: params[:code]
  end
end