class AddressesController < ApplicationController
  before_filter :set_addressable
  load_and_authorize_resource

  def show
    respond_to do |format|
      format.json { render json: @address }
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
    @address.addressable = @addressable

    respond_to do |format|
      if @address.save
        format.html { redirect_to_parent notice: 'Address was successfully added.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    @address.addressable = @addressable

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
  def set_addressable
    @addressable = Member.find(params[:member_id]) if params[:member_id]
    @addressable = Contact.find(params[:contact_id]) if params[:contact_id]
  end

  def redirect_to_parent options={}
    redirect_to edit_member_path(@addressable), options if @addressable.class == Member
    redirect_to edit_contact_path(@addressable), options if @addressable.class == Contact
  end
end
