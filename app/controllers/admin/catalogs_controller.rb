class CatalogsController < AdminController
  load_and_authorize_resource
  
  def index
    @catalog = Catalog.find(Catalog.root.id)
    
    respond_to do |format|
      format.html { render :action => "show" }
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
    @catalog.catalog = Catalog.find(params[:catalog_id])
    
    respond_to do |format|
      if @catalog.save
        format.html { redirect_to(@catalog, :notice => 'Catalog was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end
  end
  
  def update
    respond_to do |format|
      if @catalog.update_attributes(params[:catalog])
        format.html { redirect_to(@catalog.catalog, :notice => 'Catalog was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end
  
  def destroy
    @catalog.destroy
    
    respond_to do |format|
      format.html { redirect_to(@catalog.catalog) }
    end
  end
end
