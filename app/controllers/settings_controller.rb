class SettingsController < ApplicationController
  def index
    @settings = Setting.application.visible.all
    unauthorized! if cannot? :index, @settings
  end
  
  def update
    @settings = Setting::Composite.new(params[:setting])
    unauthorized! if cannot? :update, @settings
    
    respond_to do |format|
      if @settings.save
        format.html { redirect_to(settings_path, :notice => 'Settings were successfully changed.') }
      else
        format.html { redirect_to(settings_path, :notice => 'Settings were not successfully changed.') }
      end
    end
  end
end
