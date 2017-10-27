class CatsController < ApplicationController
  before_action :owns_cat, only: [:show, :edit, :update]

  def index
    @cats = Cat.all
    render :index
  end

  def show
    @cat = Cat.find(params[:id])
    render :show
  end

  def new
    @cat = Cat.new
    render :new
  end

  def create
    @cat = Cat.new(cat_params)
    @cat.user_id = current_user.id
    if @cat.save
      redirect_to cat_url(@cat)
    else
      flash.now[:errors] = @cat.errors.full_messages
      render :new
    end
  end

  def edit
    redirect_to cats_url unless @owns_cat
    @cat = Cat.find(params[:id])
    render :edit
  end

  def update
    redirect_to cats_url unless @owns_cat
    @cat = Cat.find(params[:id])
    if @cat.update_attributes(cat_params)
      redirect_to cat_url(@cat)
    else
      flash.now[:errors] = @cat.errors.full_messages
      render :edit
    end
  end

  private

  def cat_params
    params.require(:cat).permit(:age, :birth_date, :color, :description, :name, :sex)
  end

  def owns_cat
    @owns_cat = true
    cat = Cat.find(params[:id])
    @owns_cat = false unless cat
    @owns_cat = false if cat.owner != current_user
  end
end
