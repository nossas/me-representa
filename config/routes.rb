CariocaPergunta::Application.routes.draw do
  match '/auth/:provider/callback',   :to => 'sessions#create'

  get '/dataclip/candidatos/responderam', :to => 'dataclip#responderam', :as => :dataclip_who_answer

  post '/candidates/check', to: 'candidates#check', as: :candidates_check
  resources :likes, only: [:create, :update]

  get   '/about', :to => 'main#about', as: :about

  get   '/contact', :to => 'contact#show', as: :contact
  post  '/contact', :to => 'contact#create'
  
  resources :candidates do
    resources :answers, except: [:destroy] 
    put :finish
  end

  resources :unions, :parties, only: [:index, :show] do 
    resources :candidates, only: [:index, :show]
  end

#  Retiradas para nova edição - merepresenta. (votes#create e questions#(index/create/new/edit/show/update/destroy) )
#  resources :questions do
#    resources :votes, :only => :create
#  end

  resources :users, only: [:index, :new, :create, :update, :edit] do
    resources :answers, except: [:index, :new, :destroy]
    resources :parties, :unions, only: [:index] do
      resources :candidates
    end
  end

  resources :subscribers
  
  resources :sessions,    only: [:destroy, :new]
  
  get '/cities/:id/convine',    :to => "cities#convine",  as: :city_convine
  get '/cities/:id/candidates',    :to => "cities#candidates",  as: :city_candidates
  resources :cities,      only: [:index] 
  
  get 'auth/meurio',      as: :meurio_auth
  get 'auth/facebook',    as: :facebook_auth
  get 'home', :to => "candidates#home", :as => :candidates_home

  resources :answers, except: [:destroy]

  root :to => "main#index"
end
