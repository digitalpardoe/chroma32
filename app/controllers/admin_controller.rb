class AdminController < ApplicationController
  layout "admin"
  
  before_filter :authorize, :except => :download
  
  def index
    
  end
  
  private
  def authorize
    unless current_user && current_user.role?(:admin)
      redirect_to root_path
    end
  end
end