class SubdomainIsPresent
  def self.matches?(request)
    request.subdomain.present?
  end
end

Rails.application.routes.draw do

  root 'tenants#index'
  resources :tenants, only: [:index, :create]

  constraints(SubdomainIsPresent) do
    resources :tasks, only: [:index, :create, :edit]
  end
end
