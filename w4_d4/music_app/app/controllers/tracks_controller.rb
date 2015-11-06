class TracksController < ApplicationController
  before_action :require_current_user!

  def index
    @track = Track.all
    render :index
  end

  def new
    @track = Track.new
    @albums = Album.all
    render :new
  end

  def create
    @track = Track.new(track_params)
    if @track.save
      redirect_to track_url(@track)
    else
      flash.now[:errors] = @track.errors.full_messages
    end
  end

  def edit
    @track = Track.find(params[:id])
    render :edit
  end

  def destroy
    @track = Track.find(params[:id])
    render json: @track.destroy
  end

  def show
    @track = Track.find(params[:id])
    render :show
  end


  private
  def track_params
    params.require(:track).permit(:name, :album_id, :track_type, :lyrics)
  end
end
