class ApplicationController < ActionController::Base
  before_action :authorize

  private

  def authorize
    head :unauthorized if logged_out?
  end

  def logged_out?
    session[:user_id].nil?
  end
end
