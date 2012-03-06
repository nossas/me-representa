CariocaPergunta::Application.routes.draw do

  post '/users/' => "users#create"


  resources :questions

  root :to => "users#index"
end
