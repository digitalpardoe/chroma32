class UserSessionsController < ApplicationController
  # CanCan convenience method
  load_and_authorize_resource

  def new
    respond_to do |format|
      format.html
    end
  end

  def create
    respond_to do |format|
      if @user_session.save
        format.html do
          # If the user is an admin redirect to the administrative
          # area, otherwise redirect to the website homepage
          if @user_session.record.role?(:admin)
            redirect_to(admin_root_path, :notice => 'Login successful.')
          else
            redirect_to(root_path, :notice => 'Login successful.')
          end
        end
      else
        format.html { render :action => "new" }
      end
    end
  end

  def destroy
    current_user_session.destroy

    respond_to do |format|
      format.html { redirect_to(root_path) }
    end
  end
end
