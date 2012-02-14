class PlacesController < ApplicationController
  load_and_authorize_resource

  def index
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @places }
    end
  end

  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @place }
    end
  end
end
