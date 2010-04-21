class Admin::PluginsController < AdminController
  # This basically stops the show method being protected
  # by the AdminContoller's overruling 'before_filter' protection
  prepend_before_filter :show, :only => :show
  
  def index
    @actives = PLUGIN_CONFIG
    @inactives = INACTIVE_PLUGIN_CONFIG
  end
  
  def show
    # Stream the binary data to the user's brower, after
    # locating it on the file system of course
    send_file "#{PLUGINS_DIR}/#{params[:name]}/public/#{params[:resource]}/#{params[:filename]}.#{params[:format]}", :type => Mime::Type.lookup_by_extension(params[:format]), :disposition => "inline", :stream => false
  end
  
  def update
    FileUtils.mv(File.join(INACTIVE_PLUGINS_DIR, params[:id]), File.join(PLUGINS_DIR, params[:id]))
    FileUtils.touch(File.join("#{Rails.root}", "tmp", "restart.txt"))
    redirect_to(admin_plugins_path)
  end
  
  def destroy
    FileUtils.mv(File.join(PLUGINS_DIR, params[:id]), File.join(INACTIVE_PLUGINS_DIR, params[:id]))
    FileUtils.touch(File.join("#{Rails.root}", "tmp", "restart.txt"))
    redirect_to(admin_plugins_path)
  end
end