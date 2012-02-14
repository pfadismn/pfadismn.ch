class PhoneNumbersController < ApplicationController
  before_filter :set_phonable
  load_and_authorize_resource
  
  def show
    respond_to do |format|
      format.json { render json: @phone_number }
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
    @phone_number.phonable = @phonable

    respond_to do |format|
      if @phone_number.save
        format.html { redirect_to_parent notice: 'Phonenumber was successfully added.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    @phone_number.phonable = @phonable

    respond_to do |format|
      if @phone_number.update_attributes(params[:phone_number])
        format.html { redirect_to_parent notice: 'Phonenumber was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    @phone_number.destroy

    respond_to do |format|
      format.html { redirect_to_parent notice: 'Phonenumber was successfully destroyed.' }
      format.json { head :ok }
    end
  end

  private
  def set_phonable
    @phonable = Member.find(params[:member_id]) if params[:member_id]
    @phonable = Contact.find(params[:contact_id]) if params[:contact_id]
  end

  def redirect_to_parent options={}
    redirect_to edit_member_path(@phonable), options if @phonable.class == Member
    redirect_to edit_contact_path(@phonable), options if @phonable.class == Contact
  end
end
