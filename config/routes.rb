class SubdomainPresent
  def self.matches? request
    request.subdomain.present?
  end
end

class SubdomainBlank
  def self.matches? request
    request.subdomain.blank? || Apartment::Elevators::Subdomain.excluded_subdomains.include?(request.subdomain)
  end
end

class SubdomainNotBlank
  def self.matches? request
    !request.subdomain.blank?
  end
end

Rails.application.routes.draw do
  constraints(SubdomainPresent) do
    root "welcome#login", as: :login
    devise_for :user, controllers: { sessions: "sessions", invitations: "invitations" }
    resources :users, only: [:index, :destroy]
    resources :projects, only: [:index, :create, :update, :destroy]
  end

  constraints(SubdomainBlank) do
    root "welcome#index"
    resources :accounts, only: [:create, :destroy]
  end
end
