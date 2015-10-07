class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def site_name
  	@site_name ||= "Album Index"
  end
  helper_method :site_name
end
