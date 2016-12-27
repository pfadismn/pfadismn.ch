class PhotosController < ApplicationController
  include PhotoCollection
 
  def cacheable?
    current_user.blank?
  end
  
  def index
    @album_years = AlbumFactory.list_years
        
    respond_to do |format|
      format.html { }
      format.json { render json: @album_years }
    end
  end
  
  def new
    authorize! :create, AlbumUpload
    @album = AlbumUpload.new
    @album.year = Date.today.year
  end
  
  def create
    authorize! :create, AlbumUpload
    expire_action action: :index
    @album = AlbumUpload.new(params["photo_collection_album_upload"])
    
    respond_to do |format|
      if @album.save
        format.html { redirect_to photos_path, notice: "Album wurde hochgeladen" }
      else
    authorize! :create, AlbumUpload
        format.html { render 'new' }
      end
    end
  end

  def show
    @album = AlbumFactory.build(params[:year], params[:id])
    
    respond_to do |format|
      if @album.blank?
        format.html { redirect_to photos_path }
      else
        format.html { }
        format.json { render json: @album }
      end
    end
  end
  
  def destroy
    authorize! :destroy, AlbumUpload
    @album = AlbumFactory.build(params[:year], params[:id])
    
     respond_to do |format|
      if @album.destroy
        format.html { redirect_to photos_path, notice: "Album wurde entfernt." }
      else
        format.html { redirect_to photos_path, alert: "Album konnte nicht entfernt werden." }
      end
    end
  end
end
