class Admin::PluginsController < AdminController
  # This basically stops the show method being protected
  # by the AdminContoller's overruling 'before_filter' protection
  prepend_before_filter :show, :only => :show
  
  def show
    # Stream the binary data to the user's brower, after
    # locating it on the file system of course
    send_file "#{PLUGINS_DIR}/#{params[:name]}/public/#{params[:resource]}/#{params[:filename]}.#{params[:format]}", :type => Mime::Type.lookup_by_extension(params[:format]), :disposition => "inline", :stream => false
  end
end