# Application handler
class ApplicationController < ActionController::Base
  before_action :devise_names_configuration

  decent_configuration do
    strategy DecentExposure::StrongParametersStrategy
  end

  protect_from_forgery with: :exception

  protected

  def devise_names_configuration
    devise_parameter_sanitizer.for(:sign_up) << :firstname << :lastname if devise_controller?
  end
end
