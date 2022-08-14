class ApplicationController < ActionController::Base
  before_action :authorize

  private

  def authorize
    head :unauthorized if logged_out?
  end

  def logged_out?
    session[:user_id].nil?
  end

  def current_user
    User.find(session[:user_id])
  end
end
