class CatRentalRequestsController < ApplicationController
  def new
    @rental = CatRentalRequest.new
    @cats = Cat.all
    render :new
  end

  def create
    @rental = CatRentalRequest.new(rental_params)
    @cats = Cat.all
    cat = Cat.find(rental_params[:cat_id])
    if @rental.save
      redirect_to cat_url(cat)
    else
      render :new
    end
  end

  def approve
    @rental = CatRentalRequest.find(params[:id])
    @rental.approve!
    cat = @rental.cat
    redirect_to cat_url(cat)
  end

  def deny
    @rental = CatRentalRequest.find(params[:id])
    @rental.deny!
    cat = @rental.cat
    redirect_to cat_url(cat)
  end

  private
  def rental_params
    params.require(:cat_rental_request).permit(:cat_id, :start_date, :end_date)
  end
end
