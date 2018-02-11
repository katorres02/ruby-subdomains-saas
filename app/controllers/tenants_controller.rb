class TenantsController < ApplicationController
  def index 
    @tenant = Tenant.new
    tenants
  end

  def create
    @tenant = Tenant.new(tenant_params)
    @tenant.save if @tenant.valid?
    redirect_to root_path
  end

private

  def tenants
    @tenants = Tenant.order(name: :asc)
  end

  def tenant_params
    params.require(:tenant).permit(:name)
  end
end