class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  helper_method :current_user

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def require_webmaster
    unless current_user && current_user.is_webmaster?
      redirect_to root_path, notice: "Unauthorized"
    end
  end

  def require_admin
    unless current_user && current_user.is_admin?
      redirect_to root_path, notice: "Unauthorized"
    end
  end

end