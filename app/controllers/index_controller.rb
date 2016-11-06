class IndexController < ApplicationController
  def index
    @news = News.published_to(:web).first(5)
    @ou = OrganisationalUnit.by_name(params[:id])
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

  def faq
  end

  def downloads
    @downloads_aktuelles = Dir.glob("#{Rails.root}/public/downloads/aktuelles/*.pdf").sort
    @downloads_admin = Dir.glob("#{Rails.root}/public/downloads/administratives/*.pdf").sort
    @downloads_press = Dir.glob("#{Rails.root}/public/downloads/presse/*.pdf").sort
  end

end
