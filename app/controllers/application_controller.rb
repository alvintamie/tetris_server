class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :current_user
  helper_method :current_user, :redirect_if_logged_in
  private
  def current_user
    @current_user ||= User.find(session[:user_id])# if session[:user_id]
  end

  def get_entity_auto_id klass
    get_entity klass.find_by_id params[:id]
  end

  def redirect_if_logged_in!
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
    redirect_to dashboard_path and return if @current_user.present?
  end

  def current_user_status_to_open
    current_user.set_status_open unless current_user.is_open?
  end
  
end
