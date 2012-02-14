class ContactsController < ApplicationController
  load_and_authorize_resource
  before_filter :set_member

  def show
    respond_to do |format|
      format.json { render json: @contact }
    end
  end

  def new
    @contact.build_address
    @contact.build_phone_number

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  def edit
  end

  def create
    respond_to do |format|
      if @address.save
        format.html { redirect_to_parent notice: 'Address was successfully added.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    respond_to do |format|
      if @address.update_attributes(params[:address])
      format.html { redirect_to_parent notice: 'Address was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    @address.destroy

    respond_to do |format|
      format.html { redirect_to_parent notice: 'Address was successfully deleted.' }
    end
  end

  private
  def set_member
    @member = Member.find(params[:member_id]) if params[:member_id]
  end

  def redirect_to_parent options={}
    redirect_to edit_member_path(@member), options if @member
  end
end
