class Api::MustdosController < ApplicationController

  def create
    mustdo = Mustdo.new(mustdo_params)
    if mustdo.save
      render json: mustdo
    else
      render json: ["Error creating item"]
    end
  end

  def index
    render json: Mustdo.all
  end

  def destroy
    mustdo = Mustdo.find(params[:id])
    if mustdo.delete
      render json: mustdo
    else
      render json: ["Error deleting item"]
    end
  end

  def update
    mustdo = Mustdo.find(params[:id])
    if mustdo.update(mustdo_params)
      render json: mustdo
    else
      render json: ["Error updating item"]
    end
  end

  def mustdo_params
    params.require(:mustdo).permit(:title, :body, :done)
  end
end
