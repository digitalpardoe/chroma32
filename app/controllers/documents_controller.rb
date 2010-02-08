class DocumentsController < ApplicationController
  def show
    @document = Document.find(params[:id])
    @catalog = Catalog.find(params[:catalog_id])
    
    respond_to do |format|
      format.html
    end
  end
  
  def new
    @document = Document.new
    @catalog = Catalog.find(params[:catalog_id])
    
    respond_to do |format|
      format.html
    end
  end
  
  def edit
    @document = Document.find(params[:id])
  end
  
  def create
    @document = Document.new(params[:document])
    @catalog = Catalog.find(params[:catalog_id])
    @document.catalog_id = @catalog.id
    
    respond_to do |format|
      if @document.save
        format.html { redirect_to(Catalog.find(params[:catalog_id]), :notice => 'Document was successfully uploaded.') }
      else
        format.html { render :action => "new" }
      end
    end
  end
  
  def update
    @document = Document.find(params[:id])
    
    respond_to do |format|
      if @document.update_attributes(params[:document])
        format.html { redirect_to(@document.catalog, :notice => 'Document was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end
  
  def destroy
    @document = Document.find(params[:id])
    @document.destroy
    
    respond_to do |format|
      format.html { redirect_to(catalog_path(params[:catalog_id])) }
    end
  end
  
  def download
    respond_to do |format|
       format.all {
         @document = Document.where(:name => params[:id], :extension => request.format.symbol.to_s, :catalog_id => params[:catalog_id]).limit(1).first
         # TODO: X-Sendfile support, perhaps.
         send_file @document.file, :type => @document.content_type, :disposition => "attachment", :filename => "#{params[:id]}.#{request.format.symbol.to_s}", :stream => false
       }
    end
  end
end
