class PhotoAlbumsController < ApplicationController
  load_and_authorize_resource :photo_album

  def index
    @photo_albums = @photo_albums.order(created_at: :DESC)

    respond_to do |format|
      format.html { }
      format.json { render json: @photo_albums }
    end
  end

  def show
    respond_to do |format|
      if @photo_album.blank?
        format.html { redirect_to photos_path }
      else
        format.html { }
        format.json { render json: @photo_album }
      end
    end
  end

  def new
  end

  def edit
  end

  def create
      if @photo_album.save
        redirect_to photos_path, notice: "Album wurde erstellt"
      else
        render action: "new"
      end
  end

  def update
      if @photo_album.update(photo_album_params)
        redirect_to photos_path, notice: 'Album wurde upgedated.'
      else
        render action: "edit"
      end
  end

  def destroy
    @photo_album.destroy

    redirect_to photos_path
  end

  private

  def photo_album_params
    params.require(:photo_album).permit(:title, :description, :place, :flickr_url, :year)
  end
end
