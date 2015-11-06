class BandsController < ApplicationController
  before_action :require_current_user!

  def index
    @band = Band.all
    render :index
  end

  def new
    @band = Band.new
    render :new
  end

  def create
    @band = Band.new(band_params)
    if @band.save
      redirect_to band_url(@band)
    else
      flash.now[:errors] = @band.errors.full_messages
    end
  end

  def destroy
    @band = Band.find(params[:id])
    @band.destroy
    redirect_to bands_url
  end

  def show
    @band = Band.find(params[:id])
    render :show
  end


  private
  def band_params
    params.require(:band).permit(:name)
  end

end
