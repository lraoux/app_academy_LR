class CatRentalRequestsController < ApplicationController

  def approve
    current_cat_rental_request.approve!
    redirect_to cat_url(current_cat)
  end

  def deny
    current_cat_rental_request.deny!
    redirect_to cat_url(current_cat)
  end

  def index
    render text: "INDEX"
  end

  def new
    @cat_rental_request = CatRentalRequest.new
    @cat_rental_request.cat_id = params[:cat_id]

    render :new
  end

  def create
    @cat_rental_request = CatRentalRequest.new(cat_rental_request_params)
    if @cat_rental_request.save
      redirect_to cat_cat_rental_request_url(@cat_rental_request.cat_id, @cat_rental_request.id)
    else
      render :error
    end
  end

  def show
    @cat_rental_request = CatRentalRequest.find(params[:id])
    render :show
  end

  private

  def current_cat_rental_request
    @cat_rental_request ||=
      CatRentalRequest.includes(:cat).find(params[:id])
  end

  def current_cat
    current_cat_rental_request.cat
  end

  def cat_rental_request_params
    params.require(:cat_rental_request).permit(:cat_id, :start_date,
                                               :end_date, :status)
  end
end
