# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api do
    namespace :v1 do
      post 'user_token' => 'user_token#create'
      resources :users, only: %i[index destroy show]
      resources :nurse, only: %i[index show update]
      resources :status, only: [:index]
      resources :message, only: [:index]
      resources :asset, only: %i[index show destroy]
      resources :tree, only: %i[update destroy index show]
      resources :lol_champion, only: %i[index create destroy]
      resources :pokemon_pet, only: %i[index show]

      get :authors, action: :index, controller: 'author'
      get :books, to: 'book#index'
      get 'book/:book_id/display', to: 'book#display'
      get 'author/:author_id/display', to: 'author#display'
      put 'update_nurse_booked/:nurse_schedule_id', to: 'nurse#update_nurse_booked'
      get 'search_message', to: 'message#search_test'
      get 'tree/:node_id/children', to: 'tree#children', constraints: { node_id: /\d{1,10}/ }
      get 'tree/:node_id/full_parent', to: 'tree#full_parent'
      get 'ticket/', to: 'ticket#get_ticket'
    end
  end
  match '*unmatched', to: 'application#router_not_found', via: :all
end
