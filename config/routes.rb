WufooClone::Application.routes.draw do
  resource :session, :only => [:new, :create, :destroy]
  resources :users, :only => [:new, :create, :show]
  
  resources :forms, :except =>[:index] do
    resources :fields, :except => [:index, :show]
  end
  
  root :to => "sessions#new"
end
