class ApplicationController < ActionController::Base
  before_action :devise_names_configuration

  decent_configuration do
    strategy DecentExposure::StrongParametersStrategy
  end

  protect_from_forgery with: :exception

  protected

  def devise_names_configuration
    if devise_controller?
      devise_parameter_sanitizer.for(:sign_up) << :firstname << :lastname
    end
  end
end