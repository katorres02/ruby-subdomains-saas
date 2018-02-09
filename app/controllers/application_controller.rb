class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :load_schema, :authenticate_user!

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
end
