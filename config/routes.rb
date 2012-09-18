CariocaPergunta::Application.routes.draw do
  match '/auth/:provider/callback',   :to => 'sessions#create'

  post '/candidates/check', to: 'candidates#check', as: :candidates_check

  resources :parties, only: [:index, :show]
  resources :unions, only: [:show]

  resources :candidates do
    resources :answers, except: [:destroy] 
    put :finish
  end

  resources :questions do
    resources :votes, :only => :create
  end

  resources :users, only: [:index, :new, :create] do
    resources :answers, :only => [:new, :create, :update]
  end

  resources :subscribers
  resources :sessions,    only: [:destroy]
  
  get 'auth/meurio',      as: :meurio_auth
  get 'auth/facebook',    as: :facebook_auth

  root :to => "candidates#index"
end
