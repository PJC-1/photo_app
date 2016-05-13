Rails.application.routes.draw do
  root to: "users#index"

  # User/Picture resource
  resources :users do
    resources :pictures
  end

  # Pictures resource
  resources :pictures, only: [] do
    resources :comments

    # Search tags
    collection do
      get "/tags" => "pictures#tags_search"
    end
  end

  # Sessions routes
  get   "/login", to: "sessions#new"
  get   "/logout", to: "sessions#destroy"
  post  "/sessions", to: "sessions#create"

end
