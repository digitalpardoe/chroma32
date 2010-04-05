class ThemesController < AdminController
  def index
    @themes = Theme.all
    unauthorized! if cannot? :index, @themes
  end
  
  def show
    send_file "#{THEMES_DIR}/#{Setting.application.value("theme")}/#{params[:resource]}/#{params[:filename]}.#{params[:format]}", :type => Mime::Type.lookup_by_extension(params[:format]), :disposition => "inline", :stream => false
  end
  
  def update
    @theme = Theme.where(:name => params[:id]).first
    unauthorized! if cannot? :update, @theme
    
    respond_to do |format|
      if @theme.save
        format.html { redirect_to(themes_path, :notice => 'Theme was successfully changed.') }
      else
        format.html { redirect_to(themes_path, :notice => 'Theme was not successfully changed.') }
      end
    end
  end
end
