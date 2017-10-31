class GoalsController < ApplicationController
  def new
  end

  def create
    goal = Goal.new(goal_params)
    goal.user_id = current_user.id

    if goal.save
      redirect_to user_url(goal.user_id)
    else
      flash.now[:errors] = goal.errors.full_messages
      render :new
    end
  end

  def edit
  end

  def update
    @goal = Goal.find_by(id: params[:id])

    if @goal.user_id == current_user.id
      if @goal.update_attributes(goal_params)
        redirect_to users_url(@goal.user_id)
      else
        flash.now[:errors] = @goal.errors.full_messages
        render :edit
      end
    else
      flash[:errors] = ["You don't own this goal."]
      redirect_to users_url
    end
  end

  def destroy
    @goal = Goal.find_by(id: params[:id])
    if @goal
      @goal.destroy!
      redirect_to users_url
    else
      flash[:errors] = ["Goal doesn't exist."]
      redirect_to users_url
    end
  end

  private
  def goal_params
    params.require(:goal).permit(:goal)
  end
end
