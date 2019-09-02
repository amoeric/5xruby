class ErrorsController < ApplicationController
  #當code 是什麼就render什麼
  layout 'errors'
  def not_found
    render '404', status: 404
  end

  def internal_server_error
    render '500', status: 500
  end
end