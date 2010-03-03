class ArticlesController < ApplicationController
  load_and_authorize_resource
  
  def index
    @articles = Article.all

    respond_to do |format|
      format.html
    end
  end

  def show
    respond_to do |format|
      format.html
    end
  end
end
