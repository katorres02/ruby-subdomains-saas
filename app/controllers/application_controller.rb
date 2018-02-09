class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :load_schema, :authenticate_user!, :set_mailer_host
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:accept_invitation, keys: [:name])
  end

  private

  def load_schema
  	Apartment::Tenant.switch!('public')
  	return unless request.subdomain.present?

  	if current_account
  		Apartment::Tenant.switch!(request.subdomain)
  	else
  		redirect_to root_url(subdomain: false)
  	end
  end

  def after_sign_out_path_for(resource)
  	new_user_session_path
  end

  def current_account
    @current ||= Account.find_by(subdomain: request.subdomain)
  end
  helper_method  :current_account

  def set_mailer_host
    subdomain = current_account ? "#{current_account.subdomain}." : ""
    ActionMailer::Base.default_url_options[:host] = "#{subdomain}lvh.me:3000"
  end

  def after_invite_path_for(resource)
    users_path
  end
end
