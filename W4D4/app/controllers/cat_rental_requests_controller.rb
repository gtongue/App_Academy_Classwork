class CatRentalRequestsController < ApplicationController
  before_action :owns_cat, only: [:approve, :deny]

  def approve
    unless @owns_cats
      redirect_to cats_url
      return
    end

    current_cat_rental_request.approve!
    redirect_to cat_url(current_cat)
  end

  def create
    @rental_request = CatRentalRequest.new(cat_rental_request_params)
    @rental_request.user_id = current_user.id
    if @rental_request.save
      redirect_to cat_url(@rental_request.cat)
    else
      flash.now[:errors] = @rental_request.errors.full_messages
      render :new
    end
  end

  def deny
    unless @owns_cats
      redirect_to cats_url
      return
    end
    current_cat_rental_request.deny!
    redirect_to cat_url(current_cat)
  end

  def new
    @rental_request = CatRentalRequest.new
  end

  private

  def current_cat_rental_request
    @rental_request ||=
      CatRentalRequest.includes(:cat).find(params[:id])
  end

  def current_cat
    current_cat_rental_request.cat
  end

  def cat_rental_request_params
    params.require(:cat_rental_request).permit(:cat_id, :end_date, :start_date, :status)
  end

  def owns_cat
    @owns_cat = true
    cat = Cat.find(params[:id])
    @owns_cat = false unless cat
    @owns_cat = false if cat.owner != current_user
  end
end
