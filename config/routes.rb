CariocaPergunta::Application.routes.draw do
  match '/auth/:provider/callback',   :to => 'sessions#create'

  post '/candidates/check', to: 'candidates#check', as: :candidates_check

  resources :candidates do
    resources :answers, except: [:destroy] 
    put :finish
  end

  resources :parties, only: [:show]
  resources :unions, only: [:show]

  resources :questions do
    resources :votes, :only => :create
  end

  resources :users, only: [:index, :new, :create] do
    resources :answers, :only => [:new, :create, :update]
    resources :parties, only: [:index]
  end

  resources :subscribers
  resources :sessions,    only: [:destroy]
  
  get 'auth/meurio',      as: :meurio_auth
  get 'auth/facebook',    as: :facebook_auth

  root :to => "candidates#index"
end
