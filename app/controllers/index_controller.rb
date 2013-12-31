class IndexController < ApplicationController
  def index
    @news = News.all
    @ou = OrganisationalUnit.find_by_name(params[:id])
  end
  
  def dashboard
  end

  def impressum
  end
  
  def jahresprogramm
    send_file "#{Rails.root}/public/jahresprogramm.pdf", type: 'application/pdf', disposition: 'inline'
  end

  def chronik
  end

  def rheinfallmarsch
  end
  
  def downloads
    @downloads_aktuelles = Dir.glob("#{Rails.root}/public/downloads/aktuelles/*.pdf")
    @downloads_admin = Dir.glob("#{Rails.root}/public/downloads/administratives/*.pdf")
    @downloads_press = Dir.glob("#{Rails.root}/public/downloads/presse/*.pdf")
  end

end
