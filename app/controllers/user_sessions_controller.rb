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
        format.html { redirect_to(@user_session, :notice => 'UserSession was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def destroy
    @user_session.destroy

    respond_to do |format|
      format.html { redirect_to(user_sessions_url) }
    end
  end
end
