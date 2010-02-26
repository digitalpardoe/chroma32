class ThemeController < ApplicationController
  def show
    send_file "#{THEMES_DIR}/#{Setting.application.value("theme")}/#{params[:resource]}/#{params[:filename]}.#{params[:format]}", :type => Mime::Type.lookup_by_extension(params[:format]), :disposition => "inline", :stream => false
  end
end
