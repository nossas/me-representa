CariocaPergunta::Application.routes.draw do
  match '/auth/:provider/callback', :to => 'sessions#create'
  post '/users/' => "users#new"
  root :to => "users#index"
end
