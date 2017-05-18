class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  prepend_before_filter :confirm_connection
def confirm_connection
  c = ActiveRecord::Base.connection
  begin
    c.select_all "SELECT 1"
  rescue ActiveRecord::StatementInvalid
    ActiveRecord::Base.logger.warn "Reconnecting to database"
    c.reconnect!
  end
end

  include Pundit

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :load_ads
  before_action :store_current_location, unless: :devise_controller?

  protected

    def configure_permitted_parameters
      devise_params = [:first_name, :last_name, :address_1, :city, :state, :zip, :phone, :profile_image, :newsletter_subscriber]
      devise_parameter_sanitizer.for(:sign_up).concat(devise_params)
      devise_parameter_sanitizer.for(:account_update).concat(devise_params)
    end

    def load_ads
      @top_ad = Ad.top.first
      @sidebar_ads = Ad.sidebar
    end

  private

    def store_current_location
      store_location_for(:user, request.url)
    end
end
