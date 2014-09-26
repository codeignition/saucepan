class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :force_profile_update

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = exception.message
    redirect_to authenticated_root_path
  end

  private
  def force_profile_update
    redirect_to new_profile_path if !current_user.nil? and ![new_profile_path, profile_path].include?(request.path) and current_user.force_profile_update?
  end
end
