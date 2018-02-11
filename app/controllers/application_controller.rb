class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :load_schema


  private

  def load_schema
  	Apartment::Tenant.switch!('public')
  	return unless request.subdomain.present?

  	if current_subdomain
  		Apartment::Tenant.switch!(request.subdomain)
  	else
  		redirect_to root_url(subdomain: false)
  	end
  end

  def current_subdomain
    @current ||= Tenant.find_by(name: request.subdomain)
  end
end
