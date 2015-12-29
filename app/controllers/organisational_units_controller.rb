class OrganisationalUnitsController < ApplicationController
  #load_and_authorize_resource

  def index
    redirect_to organisational_unit_path('abteilung')
  end

  def show
    @ou = OrganisationalUnit.by_name(params[:id]).take!
  end

  def rheinfallmarsch
  end

  def chronik
  end
end
