class DocumentsController < ApplicationController
  def new
    @document = Document.new
    @catalog = Catalog.find(params[:catalog_id])
    
    respond_to do |format|
      format.html
    end
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
end
