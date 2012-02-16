class MeetingProtocolsController < ApplicationController
  load_and_authorize_resource

  def index
    respond_to do |format|
      format.html
    end
  end

  def show
    respond_to do |format|
      format.html # index.html.erb
      format.pdf {
        pdf_renderer = PDFKit.new(@meeting_protocol.to_html)
        pdf_renderer.stylesheets << "#{Rails.root}/app/assets/stylesheets/pdf.css"
        send_data(pdf_renderer.to_pdf, filename: "protocol.pdf", type: 'application/pdf')
      }
    end
  end

  def new
    
    respond_to do |format|
      format.html # new.html.erb
    end
  end

  def edit
  end

  def create
    respond_to do |format|
      
      if @meeting_protocol.save
        format.html { redirect_to meeting_protocols_path, notice: 'Protocol was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
#    @meeting_protocol.participants << Member.all.first

    respond_to do |format|
      if @meeting_protocol.update_attributes(params[:meeting_protocol])
        format.html { redirect_to meeting_protocols_path, notice: 'Protocol was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    @meeting_protocol.destroy

    respond_to do |format|
      format.html { redirect_to meeting_protocols_path }
    end
  end
end
