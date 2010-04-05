class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :themeify
  
  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Access denied."
    redirect_to root_path
  end
  
  helper_method :current_user_session, :current_user
  
  private
  def themeify
    prepend_view_path("#{THEMES_DIR}/#{Setting.application.value("theme")}/views")
  end
  
  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.record
  end
end
