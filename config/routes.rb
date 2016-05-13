Rails.application.routes.draw do

  get 'user/index'

  devise_for :users
  root to: "users#index"

  # User/Picture resource
  resources :users

  resources :pictures

  # Pictures resource
  resources :pictures, only: [] do
    resources :comments

    # Search tags
    collection do
      get "/tags" => "pictures#tags_search"
    end
  end

end
