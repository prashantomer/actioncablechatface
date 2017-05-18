Rails.application.routes.draw do
  match '/auth/:provider/callback' => 'authentications#create', via: [:get, :post]
  root 'home#home'
 
  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations"
  }
 	mount ActionCable.server => '/cable'

  resources :conversations, only: [:create] do
    member do
      post  :close
    end
    resources :messages, only: [:create]
  end

  resources :home, only: [:index] do
  	collection do
  		get   :home
  	end
    member do
      get   :user_edit
      put   :user_edit
      get   :user_avatar
      post  :user_avatar      
    end
  end
end