class Admin::ThemesController < AdminController
  # This basically stops the show method being protected
  # by the AdminContoller's overruling 'before_filter' protection
  prepend_before_filter :show, :only => :show
  
  def index
    # Get a list of all available themes
    @themes = Theme.all
    
    # Check user permission to view the themes
    unauthorized! if cannot? :index, @themes
  end
  
  def show
    # Streams the binary data of the requested theme resource
    # to the user's browser
    send_file "#{THEMES_DIR}/#{Setting.application.value("theme")}/#{params[:resource]}/#{params[:filename]}.#{params[:format]}", :type => Mime::Type.lookup_by_extension(params[:format]), :disposition => "inline", :stream => false
  end
  
  def update
    # Search for the selected theme (actually creates a new
    # 'theme' object) that we can persist to the database
    @theme = Theme.where(:name => params[:id]).first
    
    # Check user can update the theme
    unauthorized! if cannot? :update, @theme
    
    respond_to do |format|
      if @theme.save
        format.html { redirect_to(admin_themes_path, :notice => 'Theme was successfully changed.') }
      else
        format.html { redirect_to(admin_themes_path, :notice => 'Theme was not successfully changed.') }
      end
    end
  end
end
