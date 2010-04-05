class UserSessionsController < ApplicationController
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
          if @user_session.record.role?(:admin)
            redirect_to(admin_root_path, :notice => 'User Session was successfully created.')
          else
            redirect_to(root_path, :notice => 'User Session was successfully created.')
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
      format.html { redirect_to(root_url) }
    end
  end
end
