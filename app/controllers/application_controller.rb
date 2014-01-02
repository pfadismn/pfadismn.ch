class ApplicationController < ActionController::Base
  protect_from_forgery
  helper :all
  helper_method :current_user_session, :current_user

  private
  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.record
  end

  def store_location
    session[:return_to] = request.url
  end

  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end

  rescue_from ActionController::RoutingError, AbstractController::ActionNotFound, ActiveRecord::RecordNotFound do |ex|
    render file: 'public/404', status: 404, layout: false
  end

  rescue_from CanCan::AccessDenied do |exception|
    if current_user.present?
      flash[:alert] = "Zugriff verweigert!"
      store_location
      redirect_to request.referer || index_path
    else
      flash[:alert] = "Login erforderlich!"
      store_location
      redirect_to login_path
    end
  end
end
