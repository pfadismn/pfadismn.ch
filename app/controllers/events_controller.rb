# encoding: UTF-8

class EventsController < ApplicationController
  before_filter :inject_publish, only: [ :create, :update ]
  load_and_authorize_resource except: [:show]
  
  def index
    @events = @events.active.upcoming
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @events }
    end
  end

  def show
    @event = Event.where(id: params[:id]).first
    @event ||= Event.active.upcoming.where(name: params[:id]).first unless @event || params[:id].blank?
    
    respond_to do |format|
      if @event.present?
        format.html # show.html.erb
        format.json { render json: @event }
      else
        format.html { redirect_to events_path }
      end
    end
  end

  def new
    tl = <<-tl
Pfadihemd
Kravatte
    tl
    
    @event.published_at ||= Time.now
    @event.start_time ||= Time.now + (5*24*60*60)
    @event.end_time ||= Time.now + (5*24*60*60)
    @event.take_along ||= tl
  end

  def edit
  end

  def create
    @event.organisational_unit = current_user.member.organisational_unit unless current_user.has_role?( :admin || :manager )
    @event.creator = current_user
    
    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Planned activity was successfully created.' }
        format.json { render json: @event, status: :created, location: @event }
      else
        format.html { render action: "new" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.html { redirect_to @event, notice: 'Planned activity was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    respond_to do |format|
      format.html { redirect_to events_url }
      format.json { head :ok }
    end
  end
  
  private
  def inject_publish
    if params[:event].present? && params[:event][:published].present?
      if params[:event][:published] == "1"
        params[:event][:published_at] = Time.now
      else
        params[:event][:published_at] = nil
      end
      params[:event].delete :published
    end
  end
end
