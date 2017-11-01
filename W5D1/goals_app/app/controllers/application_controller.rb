class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :login

  def login(user)
    session[:session_token] = user.session_token
  end

  def logout!
    current_user.session_token = SecureRandom::urlsafe_base64(16)
    current_user.save
    session[:session_token] = nil
  end

  def current_user
    return nil unless session[:session_token]
    @current_user ||= User.find_by(session_token: session[:session_token])
  end
end