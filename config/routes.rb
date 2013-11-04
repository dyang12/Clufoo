WufooClone::Application.routes.draw do
  resource :session, :only => [:new, :create, :destroy]
  resources :users, :only => [:new, :create, :show]
  
  resources :forms do
    resources :fields, :only => [:index, :new]
  end
  resources :fields, :except => [:index, :new]
end
