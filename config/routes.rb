class SubdomainIsPresent
  def self.matches?(request)
    request.subdomain.present?
  end
end

class SubdomainInBlank 
  def self.matches?(request)
    request.subdomain.blank?
  end
end

Rails.application.routes.draw do
# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  constraints(SubdomainIsPresent) do
    root 'projects#index', as: :subdomain_root 
    devise_for :users
  end

  constraints(SubdomainInBlank) do
    root 'welcomes#index'
    resources :accounts, only: [:new, :create] 
  end
end
