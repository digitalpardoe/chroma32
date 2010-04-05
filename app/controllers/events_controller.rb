class EventsController < ApplicationController
  before_filter :authorize
  
  def index
    @events = Event.where("events.id IN (?)", Event.joins(:roles).where("roles.id IN (?)", current_user.roles).select("DISTINCT events.id"))
  end

  def show
    @event = Event.find(params[:id])
    unauthorized! if cannot? :read, @event
    @documents = Document.where("catalog_id IN (?)", @event.catalogs).order("created_at ASC")
  end
end
