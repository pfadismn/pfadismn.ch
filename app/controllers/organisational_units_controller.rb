class OrganisationalUnitsController < ApplicationController
  #load_and_authorize_resource

  def show
    @ou = OrganisationalUnit.find_by_name(params[:id])
    
    respond_to do |format|
      format.html
    end
  end
  
  def rheinfallmarsch
  end
  
  def chronik
  end
end
