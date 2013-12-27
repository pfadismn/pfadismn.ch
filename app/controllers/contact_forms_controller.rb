class ContactFormsController < ApplicationController
  
  def new
    @contact_form = ContactForm.new
    @ou = params[:organisational_units_id]
  end

  def create
    puts '---------------------------------------------'
    puts @contact_form.name
    puts '---------------------------------------------'
  end

end
