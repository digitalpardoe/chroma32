class Admin::RolesController < AdminController
  # CanCan convenience method
  load_and_authorize_resource
  
  def index
    @roles = Role.visible
    
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
      if @role.save
        format.html { redirect_to(admin_roles_path, :notice => 'Role was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    respond_to do |format|
      if @role.update_attributes(params[:role])
        format.html { redirect_to(admin_roles_path, :notice => 'Role was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @role.destroy

    respond_to do |format|
      format.html { redirect_to(admin_roles_path) }
    end
  end
end
