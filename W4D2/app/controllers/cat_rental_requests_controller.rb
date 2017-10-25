class CatRentalRequestsController < ApplicationController
  def new
    render :new
  end

  def create
    @request = CatRentalRequest.new(request_params)
    @request.status = 'PENDING'

    if @request.save
      redirect_to cats_url
    else
      render :new
    end
  end

  private

  def request_params
    params.require(:request).permit(:cat_id, :start_date, :end_date)
  end

end
