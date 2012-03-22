CariocaPergunta::Application.routes.draw do

  match '/auth/:provider/callback',   :to => 'sessions#create'

  resources :questions do
    resources :votes, :only => :create
  end
  resources :users,       :only => [:new, :create]
  resources :subscribers, :only => [:create]
  resources :sessions,    :only => [:destroy]

  # Remove the default if you're running the app and not the splash page :)
  root :to => "subscribers#index", :defaults => { :is_splash => true }
end
