class ApplicationController < ActionController::Base
  private

  def logged_out?
    session[:user_id].nil?
  end
end
