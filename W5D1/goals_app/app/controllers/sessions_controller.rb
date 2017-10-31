class SessionsController < ApplicationController
  def new
    render :new
  end


  def create
    user = User.find_by_credentials(session_params[:username], session_params[:password])

    if user
      login(user)
      redirect_to users_url(user)
    else
      flash.now[:errors] = ['Invalid username or password']
      render :new
    end
  end

  def destroy
    logout!
    redirect_to new_session_url
  end

  private

  def session_params
    params.require(:session).permit(:username, :password)
  end

end
