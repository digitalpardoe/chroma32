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
