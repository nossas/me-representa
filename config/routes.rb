CariocaPergunta::Application.routes.draw do
  match '/auth/:provider/callback', :to => 'sessions#create'
  resources :questions
  resources :users, :only => [:new, :create]

  # Remove the default if you're running the app and not the splash page :)
  root :to => "users#index", :defaults => { :is_splash => true }
end
