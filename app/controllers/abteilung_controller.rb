class AbteilungController < ApplicationController
  
  def index
    @ou = OrganisationalUnit.where(name: 'Abteilung').first
    @team = @ou.members.by_function(:al)
  end

  def chronik
  end
  
  def wolfsstufe
  end

  def biberstufe
    @ou = OrganisationalUnit.where(name: 'Biberstufe').first
    @team = @ou.members.by_function(:stufenleiter)
  end
  
  def wolfsstufe
    @ou = OrganisationalUnit.where(name: 'Wolfsstufe').first
    @team = @ou.members.by_function(:stufenleiter)
  end

  def pfadistufe
    @ou = OrganisationalUnit.where(name: 'Pfadistufe').first
    @team = @ou.members.by_function(:stufenleiter)
  end


  def roverstufe
    @ou = OrganisationalUnit.where(name: 'Pfadistufe').first
    @team = @ou.members.by_function(:stufenleiter)
  end

  def elternrat
  end
  
  def apv
  end

end
