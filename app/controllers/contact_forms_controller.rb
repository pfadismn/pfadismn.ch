class ContactFormsController < ApplicationController
  before_filter :load_parent_resource
  
  def new
    @contact_form = ContactForm.new
  end

  def create
    @contact_form = ContactForm.new(contact_form_params)
    @contact_form.organisational_unit = @ou

    respond_to do |format|
      if @contact_form.save
        format.html { redirect_to organisational_unit_path(@ou), notice: 'Anfrage abgeschickt, herzlichen Dank.' }
      else
        format.html { render action: "new" }
      end
    end

  end

  private
  # Using a private method to encapsulate the permissible parameters is just a good pattern
  # since you'll be able to reuse the same permit list between create and update. Also, you
  # can specialize this method with per-user checking of permissible attributes.
  def contact_form_params
    params.require(:contact_form).permit(:name)
  end

  def load_parent_resource
    @ou = OrganisationalUnit.find_by_name(params[:organisational_unit_id])
  end
end
