CariocaPergunta::Application.routes.draw do

  match '/auth/:provider/callback',   :to => 'sessions#create'

  resources :questions do
    resources :votes, :only => :create
  end
  resources :users,       :only => [:new, :create]
  resources :subscribers
  resources :sessions,    :only => [:destroy]

  root :to => "subscribers#index", :defaults => { :is_splash => true }
end
