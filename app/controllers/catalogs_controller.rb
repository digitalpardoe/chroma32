class CatalogsController < ApplicationController
  def index
    @catalog = Catalog.find(Catalog.root.id)
    @catalogs = Catalog.where(:catalog_id => Catalog.root.id)
    
    respond_to do |format|
      format.html { render :action => "show" }
    end
  end
  
  def show
    @catalog = Catalog.find(params[:id])
    @catalogs = Catalog.where(:catalog_id => params[:id])
    
    respond_to do |format|
      format.html
    end
  end
  
  def new
    @catalog = Catalog.new
    
    respond_to do |format|
      format.html
    end
  end
  
  def create
    @catalog = Catalog.new(params[:catalog])
    @catalog.catalog_id = params[:catalog_id]
    
    respond_to do |format|
      if @catalog.save
        format.html { redirect_to(Catalog.find(params[:catalog_id]), :notice => 'Catalog was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end
  end
end
