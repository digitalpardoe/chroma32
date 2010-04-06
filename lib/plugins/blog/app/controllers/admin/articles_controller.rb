class Admin::ArticlesController < AdminController
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

  def new
    respond_to do |format|
      format.html
    end
  end

  def edit
  end

  def create
    respond_to do |format|
      if @article.save
        format.html { redirect_to(admin_article_path(@article), :notice => 'Article was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    respond_to do |format|
      if @article.update_attributes(params[:article])
        format.html { redirect_to(admin_article_path(@article), :notice => 'Article was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @article.destroy

    respond_to do |format|
      format.html { redirect_to(admin_articles_path) }
    end
  end
end