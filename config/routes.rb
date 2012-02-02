CariocaPergunta::Application.routes.draw do
  post '/users/' => "users#new"
  root :to => "users#index"
end
