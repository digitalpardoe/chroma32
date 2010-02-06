class CatalogsController < ApplicationController
  def index
    @catalogs = Catalog.all

    respond_to do |format|
      format.html
    end
  end
end
