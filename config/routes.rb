CariocaPergunta::Application.routes.draw do

  post '/users/' => "users#create"


  resources :questions

  # Remove the default if you're running the app and not the splash page :)
  root :to => "users#index", :defaults => { :is_splash => true }
end
