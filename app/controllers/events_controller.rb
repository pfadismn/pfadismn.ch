# encoding: UTF-8
class EventsController < ApplicationController
  before_filter :inject_publish, only: [ :create, :update ]
  before_filter :load_parent_resource
  load_and_authorize_resource except: [:show, :index, :quartalsprogramm]
  
  def index
    @events = @ou.events.accessible_by(current_ability).active.upcoming
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @events }
    end
  end
  
  def quartalsprogramm
    @events = @ou.events.accessible_by(current_ability).active.upcoming.limit(10)
    
    respond_to do |format|
#      format.html # index.html.erb
      format.json { render json: @events }
      format.pdf {
        pdf_renderer = PDFKit.new(render_to_string(:layout => false , :action => "quartalsprogramm.html.erb"))
        pdf_renderer.stylesheets << "#{Rails.root}/app/assets/stylesheets/pdf.css"
        send_data(pdf_renderer.to_pdf, filename: "quartalsprogramm.pdf", type: 'application/pdf')
      }
    end
  end

  def show
    @event = Event.find(params[:id])
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
    @event.organisational_unit = @ou
    
    @event.published_at ||= Time.now
    @event.start_time ||= Time.now + (5*24*60*60)
    @event.end_time ||= Time.now + (5*24*60*60)
    @event.take_along ||= tl
  end

  def edit
  end

  def create
    @event.organisational_unit = @ou unless current_user.has_role?(:admin | :manager)
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
        format.html { redirect_to [@ou, @event], notice: 'Planned activity was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    respond_to do |format|
      format.html { redirect_to organisational_unit_events_path(@ou) }
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
  
  def load_parent_resource
    @ou = OrganisationalUnit.find_by_name(params[:organisational_unit_id])
  end
end
