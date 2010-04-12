class Admin::SettingsController < AdminController
  def index
    # Get all the application (Chroma32) settings
    @settings = Setting.application.visible
    
    # Check user permissions to view settings
    unauthorized! if cannot? :index, @settings
  end
  
  def update
    # Instantiate the composite class responsible for marshalling
    # the form data into key-value columns
    @settings = Setting::Composite.new(params[:setting])
    
    # Checks the user's permissions to update settings
    unauthorized! if cannot? :update, @settings
    
    respond_to do |format|
      if @settings.save
        format.html { redirect_to(admin_settings_path, :notice => 'Settings were successfully changed.') }
      else
        format.html { redirect_to(admin_settings_path, :notice => 'Settings were not successfully changed.') }
      end
    end
  end
end
