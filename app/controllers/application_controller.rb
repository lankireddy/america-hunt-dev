class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include Pundit

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :load_ads

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up).push(:first_name, :last_name, :address_1, :city, :state, :zip, :phone, :profile_image)
  end

  def load_ads
    @top_ad = Ad.top.first
    @sidebar_ads = Ad.sidebar
  end
end
