class Admin::PluginsController < AdminController
  prepend_before_filter :show, :only => :show
  
  def show
    send_file "#{PLUGINS_DIR}/#{params[:name]}/public/#{params[:resource]}/#{params[:filename]}.#{params[:format]}", :type => Mime::Type.lookup_by_extension(params[:format]), :disposition => "inline", :stream => false
  end
end