class Admin::UsersController < AdminController
  # CanCan convenience method
  load_and_authorize_resource

  def index
    @users = User.all

    respond_to do |format|
      format.html
    end
  end

  def show
    respond_to do |format|
      format.html
    end
  end

  def new
    respond_to do |format|
      format.html
    end
  end

  def edit
  end

  def create
    respond_to do |format|
      if @user.save
        format.html { redirect_to(admin_user_path(@user), :notice => 'User was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    values = params[:user]
    roles = Array.[](values[:role_ids])
    
    @user.roles.each do |role|
      (roles << role.id) if role.hidden
    end
    
    values[:role_ids] = roles.flatten
        
    respond_to do |format|
      if @user.update_attributes(values)
        format.html { redirect_to(admin_user_path(@user), :notice => 'User was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(admin_users_path) }
    end
  end
end
