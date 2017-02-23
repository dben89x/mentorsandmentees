class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_profile
    @current_profile ||= current_user.try(:profile)
  end

  def ensure_admin
    redirect_to root_url unless current_user.admin?
  end
end
