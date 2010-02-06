class DocumentsController < ApplicationController
  def index
    @documents = Document.where(:catalog_id => params['catalog_id'])
    
    puts params

    respond_to do |format|
      format.html
    end
  end
end
