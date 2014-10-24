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

    concern :taskable do
      resources :tasks, only: [:index, :create]
    end

    resources :users, only: [:index, :destroy] do
      resources :tasks, only: [:index]
    end

    resources :projects, except: [:edit, :new], concerns: :taskable
    resources :api_logs, only: [:index]
    resources :tasks, only: [:destroy, :show, :update]
    resources :task_statuses, except: [:new, :edit]
    resources :roles, except: [:new, :edit]

    post "/favorite_projects/toggle/:project_id.json", to: "favorite_projects#toggle", as: :favorite_projects_toggle
    get "/users/:user_id/favorite_projects.json", to: "favorite_projects#index", as: :favorite_projects
  end

  constraints(SubdomainBlank) do
    root "welcome#index"
    resources :accounts, only: [:create, :destroy]
  end
end
