class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user

  def current_user
    return nil unless session[:session_token]
    tocken = SessionToken.find_by(session[:session_token])
    return nil if tocken.nil?
    @current_user ||= User.find(tocken.id)
  end

  def logged_in?
    !!current_user
  end

  def login!(user)
    session[:session_token] = user.session_token
    SessionToken.create(user_id: user.id, session_token: user.session_token)
  end

  def logout!
    session_token = SessionToken.find_by(user_id: current_user.id).where(session_token: current_user.session_token)
    session[:session_token] = nil
    session_token.destroy
  end

  def require_logged_in
    redirect_to new_session_url unless logged_in?
  end

  def require_logged_out
    redirect_to cats_url if logged_in?
  end
end
