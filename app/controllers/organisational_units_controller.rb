class OrganisationalUnitsController < ApplicationController
  #load_and_authorize_resource
  
  def index
    redirect_to organisational_unit_path('abteilung')
  end

  def show
    @ou = OrganisationalUnit.where(name: params[:id]).first!
  end
  
  def rheinfallmarsch
  end
  
  def chronik
  end
end
