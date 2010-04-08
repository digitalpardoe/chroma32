class AdminController < ApplicationController
  layout "admin"
  
  before_filter :authorize, :except => :download
  
  def index
    redirect_to admin_catalogs_path
  end
  
  private
  def authorize
    unless current_user && current_user.role?(:admin)
      redirect_to root_path
    end
  end
end