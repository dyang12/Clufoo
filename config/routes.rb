WufooClone::Application.routes.draw do
  resource :session, :only => [:new, :create, :destroy]
  resources :users, :only => [:new, :create, :show]
  
  resources :forms, :except =>[:index] do
    resources :fields, :except => [:index, :show]
    resources :entries, :only => [:index, :new, :edit]
  end
  
  resources :entries, :except => [:new, :edit, :index]

  root :to => "sessions#new"
end
