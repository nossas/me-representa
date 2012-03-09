CariocaPergunta::Application.routes.draw do
  match '/auth/:provider/callback', :to => 'sessions#create'
  resources :questions
  resources :users, :only => [:new, :create]
  resources :subscribers, :only => [:create]
  # Remove the default if you're running the app and not the splash page :)
  root :to => "subscribers#index", :defaults => { :is_splash => true }
end
