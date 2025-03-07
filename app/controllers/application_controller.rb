class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from ActionController::RoutingError, with: :render_404
  private
  def render_404
    redirect_to 'home#index', status: :not_found
  end

  protected
  

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :role, :address])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :role, :address])
  end
 
end
