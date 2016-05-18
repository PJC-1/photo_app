Rails.application.routes.draw do

  get 'about/index'

  get 'user/index'

  #Devise routes
  devise_for :users, :controllers => { registrations: 'registrations' }
  root to: "users#index"

  # User/Picture resource
  resources :users

  resources :pictures

  # Pictures resource
  resources :pictures, only: [] do
    resources :comments

   post "/comments", to: "comments#new", as: "new_comment"

    # Search tags
    collection do
      get "/tags/:tag", to: "pictures#index", as: "tag"
    end
  end

  resources :pictures do
    member do
      put "like", to: "pictures#upvote"
    end
  end


end
#
# Prefix Verb   URI Pattern                                       Controller#Action
# user_index GET    /user/index(.:format)                             user#index
# new_user_session GET    /users/sign_in(.:format)                          devise/sessions#new
# user_session POST   /users/sign_in(.:format)                          devise/sessions#create
# destroy_user_session DELETE /users/sign_out(.:format)                         devise/sessions#destroy
# user_password POST   /users/password(.:format)                         devise/passwords#create
# new_user_password GET    /users/password/new(.:format)                     devise/passwords#new
# edit_user_password GET    /users/password/edit(.:format)                    devise/passwords#edit
#         PATCH  /users/password(.:format)                         devise/passwords#update
#         PUT    /users/password(.:format)                         devise/passwords#update
# cancel_user_registration GET    /users/cancel(.:format)                           devise/registrations#cancel
# user_registration POST   /users(.:format)                                  devise/registrations#create
# new_user_registration GET    /users/sign_up(.:format)                          devise/registrations#new
# edit_user_registration GET    /users/edit(.:format)                             devise/registrations#edit
#         PATCH  /users(.:format)                                  devise/registrations#update
#         PUT    /users(.:format)                                  devise/registrations#update
#         DELETE /users(.:format)                                  devise/registrations#destroy
#    root GET    /                                                 users#index
#   users GET    /users(.:format)                                  users#index
#         POST   /users(.:format)                                  users#create
# new_user GET    /users/new(.:format)                              users#new
# edit_user GET    /users/:id/edit(.:format)                         users#edit
#    user GET    /users/:id(.:format)                              users#show
#         PATCH  /users/:id(.:format)                              users#update
#         PUT    /users/:id(.:format)                              users#update
#         DELETE /users/:id(.:format)                              users#destroy
# pictures GET    /pictures(.:format)                               pictures#index
#         POST   /pictures(.:format)                               pictures#create
# new_picture GET    /pictures/new(.:format)                           pictures#new
# edit_picture GET    /pictures/:id/edit(.:format)                      pictures#edit
# picture GET    /pictures/:id(.:format)                           pictures#show
#         PATCH  /pictures/:id(.:format)                           pictures#update
#         PUT    /pictures/:id(.:format)                           pictures#update
#         DELETE /pictures/:id(.:format)                           pictures#destroy
# picture_comments GET    /pictures/:picture_id/comments(.:format)          comments#index
#         POST   /pictures/:picture_id/comments(.:format)          comments#create
# new_picture_comment GET    /pictures/:picture_id/comments/new(.:format)      comments#new
# edit_picture_comment GET    /pictures/:picture_id/comments/:id/edit(.:format) comments#edit
# picture_comment GET    /pictures/:picture_id/comments/:id(.:format)      comments#show
#         PATCH  /pictures/:picture_id/comments/:id(.:format)      comments#update
#         PUT    /pictures/:picture_id/comments/:id(.:format)      comments#update
#         DELETE /pictures/:picture_id/comments/:id(.:format)      comments#destroy
# tags_pictures GET    /pictures/tags(.:format)                          pictures#tags_search
