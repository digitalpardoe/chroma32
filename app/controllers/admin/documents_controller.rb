class Admin::DocumentsController < AdminController
  # This before filter prevents CanCan's automatic loading of resources from
  # breaking the download action, if this isn't here we get an error
  before_filter :download, :only => :download
  
  # CanCan convenience method
  load_and_authorize_resource
  
  def show
    @catalog = Catalog.find(params[:catalog_id])
    
    respond_to do |format|
      format.html
    end
  end
  
  def new
    @catalog = Catalog.find(params[:catalog_id])
    
    respond_to do |format|
      format.html
    end
  end
  
  def edit
  end
  
  def create
    @catalog = Catalog.find(params[:catalog_id])
    @document.catalog = @catalog
    
    respond_to do |format|
      if @document.save
        format.html { redirect_to(admin_catalog_path(@catalog), :notice => 'Document was successfully uploaded.') }
      else
        format.html { render :action => "new" }
      end
    end
  end
  
  def update
    respond_to do |format|
      if @document.update_attributes(params[:document])
        format.html { redirect_to(admin_catalog_path(@document.catalog), :notice => 'Document was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end
  
  def destroy
    @document.destroy
    
    respond_to do |format|
      format.html { redirect_to(admin_catalog_path(params[:catalog_id])) }
    end
  end
  
  def download
    # Find the document being requested
    @document = Document.where(:name => params[:id], :extension => params[:format], :catalog_id => params[:catalog_id]).limit(1).first
    
    # Check the user's permission to view it using CanCan
    unauthorized! if ((cannot? :read, @document) && !@document.public)
    
    # Stream the binary data to the user's browser
    send_file eval("@document.#{params[:type]}"), :type => @document.content_type, :disposition => "attachment", :filename => "#{params[:id]}.#{params[:format]}", :stream => false
  end
end
