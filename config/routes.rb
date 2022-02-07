# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  scope "(:locale)", locale: /en|jp/ do
    namespace :api do
      namespace :v1 do
        post 'user_token' => 'user_token#create'
        resources :users, only: %i[index destroy show]
        resources :nurse, only: %i[index show update destroy create]
        resources :status, only: [:index]
        resources :message, only: [:index]
        resources :asset, only: %i[index show destroy]
        resources :tree, only: %i[update destroy index show]
        resources :lol_champion, only: %i[index create destroy]
        resources :pokemon_pet, only: %i[index show]
        resources :media_conan, only: %i[index show]
        resources :media_one_piece, only: %i[index show]
        resources :schedule, only: %i[index create update destroy show]
        resources :author, only: %i[index show destroy]
        resources :book, only: %i[index show destroy]

        patch 'update_nurse_booked/', to: 'nurse#update_nurse_booked'
        post 'nurse/add_schedules/:nurse_id', to: 'nurse#add_schedules', constraints: { nurse_id: /\d{1,10}/ }
        get 'search_message', to: 'message#search_test'
        get 'tree/:node_id/children', to: 'tree#children', constraints: { node_id: /\d{1,10}/ }
        get 'tree/:node_id/full_parent', to: 'tree#full_parent'
        get 'ticket/', to: 'ticket#get_ticket'
        get 'find_user/', to: 'users#search_by_email'
        get 'me/', to: 'users#me'
        put 'book/bulk_update', to: 'book#bulk_update'
      end
    end
    match '*unmatched', to: 'application#router_not_found', via: :all
  end
end
