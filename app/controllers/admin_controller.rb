class AdminController < ApplicationController
  layout "admin"
  
  # Run the authorize method before responding to a request
  # other than for a 'download' action (document controller,
  # protected in situ using CanCan)
  before_filter :authorize, :except => :download
  
  def index
    redirect_to admin_catalogs_path
  end
  
  private
  def authorize
    # Check the current user exists and is an administrator
    # if this criteria is not met, redirect to the homepage
    unless current_user && current_user.role?(:admin)
      redirect_to root_path
    end
  end
end