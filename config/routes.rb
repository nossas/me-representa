CariocaPergunta::Application.routes.draw do

  match '/auth/:provider/callback',   :to => 'sessions#create'

  resources :questions do
    resources :votes, :only => :create
  end
  resources :users,       :only => [:new, :create]
  resources :sessions,    :only => [:destroy]

  root :to => "questions#index"
end
