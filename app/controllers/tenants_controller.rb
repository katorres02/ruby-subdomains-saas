class TenantsController < ApplicationController
  def index
    # TODO show errors
    @tenant = Tenant.new
    tenants
  end

  def create
    @tenant = Tenant.new(tenant_params)
    if @tenant.save
      redirect_to root_path
    else
      tenants
      render 'index'
    end
  end

private

  def tenants
    @tenants = Tenant.order(name: :asc)
  end

  def tenant_params
    params.require(:tenant).permit(:name)
  end
end