class AdminController < ApplicationController
  layout "admin"
  
  before_filter :authorize
  
  def index
    
  end
  
  private
  def authorize
    unless current_user && current_user.role?(:admin)
      redirect_to root_url
    end
  end
end