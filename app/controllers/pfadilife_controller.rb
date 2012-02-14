class PfadilifeController < ApplicationController
  def index
  end

  def fotos
  end

  def videos
  end
  
  def skauty
    @issues = Dir.glob("#{Rails.root}/public/downloads/skauty/*.pdf")
  end

end
