class UsersController < ApplicationController
  def show
    user = User.find_by(uuid: params[:uuid])

    if user.nil?
      render file: Rails.public_path.join("404.html"), layout: false, status: :not_found
    else
      session[:user_id] = user.id
      redirect_to root_path
    end
  end
end
