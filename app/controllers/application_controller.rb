class ApplicationController < ActionController::Base
  protect_from_forgery
  
  # Before responding to a request run the 'themeify' method
  before_filter :themeify
  
  # Handles CanCan 'not authorized' error my redirecting the
  # user and notifying them they cannot access the requested
  # resource
  rescue_from CanCan::AccessDenied do |exception|
    flash[:notice] = "Access denied."
    redirect_to root_path
  end
  
  # Make these methods available to the helpers
  helper_method :current_user_session, :current_user
  
  private
  def themeify
    # Prepend the current theme's view paths to the application
    # view path
    prepend_view_path("#{THEMES_DIR}/#{Setting.application.value("theme")}/views")
  end
  
  # Return the current user session
  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  # Return the currently logged in user based on the
  # current user session
  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.record
  end
  
  # Ensure a user is logged in order to view protected
  # actions (unused)
  def authorize
    unless current_user
      redirect_to root_path
    end
  end
end
