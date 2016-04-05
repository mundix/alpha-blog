class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

#   Esto no se bien que hace pero son uns metodos , esto es para que este disponible en las vistas
#   Por default
  helper_method :current_user, :logged_user?, :logged_in?

#   Aqui vamos a poner los metodos para autehticar los usuairos logueados entre otros
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_user?
    !!current_user
  end

  def logged_in?
    !!current_user
  end

  def require_user
    if !logged_in?
      flash[:danger] = "You must be logged to perform this action"
      redirect_to root_path
    end
  end

end
