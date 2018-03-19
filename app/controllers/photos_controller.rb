class PhotosController < ApplicationController
  # include PhotoCollection

  def cacheable?
    current_user.blank?
  end

  def index
    # @album_years = AlbumFactory.list_years
    @album_years = nil

    respond_to do |format|
      format.html { }
      format.json { render json: @album_years }
    end
  end

  def show
    # @album = AlbumFactory.build(params[:year], params[:id])
    @album = nil

    respond_to do |format|
      if @album.blank?
        format.html { redirect_to photos_path }
      else
        format.html { }
        format.json { render json: @album }
      end
    end
  end
end
