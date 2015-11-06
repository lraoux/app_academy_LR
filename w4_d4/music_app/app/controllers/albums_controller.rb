class AlbumsController < ApplicationController
 before_action :require_current_user!

 def index
    @album = Album.all
    render :index
  end

  def new
    @album = Album.new(band_id: params[:band_id])
    @bands = Band.all
    render :new
  end

  def destroy
    @album = Album.find(params[:id])
    @album.destroy
    redirect_to band_url(@album.band_id)
  end

  def create
    @album = Album.new(album_params)
    if @album.save
      redirect_to album_url(@album)
    else
      flash.now[:errors] = @album.errors.full_messages
    end
  end

  def show
    @album = Album.find(params[:id])
    render :show
  end


  private
  def album_params
    params.require(:album).permit(:name, :band_id, :album_type)
  end
end
