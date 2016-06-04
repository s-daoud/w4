Rails.application.routes.draw do
  resources :users, only: [:new, :create, :show]
  resource :session, only: [:new, :create, :destroy]

  resources :sub_reddits, except: :destroy do
    resources :posts, only: :new
  end

  
  resources :posts, except: [:index, :new]

  root to: "sub_reddits#index"
end
