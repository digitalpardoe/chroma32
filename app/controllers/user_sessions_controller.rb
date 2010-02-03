class UserSessionsController < ApplicationController
  load_and_authorize_resource
  
  # GET /user_sessions/new
  # GET /user_sessions/new.xml
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user_session }
    end
  end

  # POST /user_sessions
  # POST /user_sessions.xml
  def create
    respond_to do |format|
      if @user_session.save
        format.html { redirect_to(@user_session, :notice => 'UserSession was successfully created.') }
        format.xml  { render :xml => @user_session, :status => :created, :location => @user_session }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user_session.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /user_sessions/1
  # DELETE /user_sessions/1.xml
  def destroy
    @user_session.destroy

    respond_to do |format|
      format.html { redirect_to(user_sessions_url) }
      format.xml  { head :ok }
    end
  end
end
