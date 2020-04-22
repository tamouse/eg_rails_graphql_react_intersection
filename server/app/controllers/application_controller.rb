class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def authorize!
    redirect_to login_url, alert: "Not authorized" unless current_user.nil?
  end
end
