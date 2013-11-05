WufooClone::Application.routes.draw do
  resource :session, :only => [:new, :create, :destroy]
  resources :users, :only => [:new, :create, :show]
  
  resources :forms, :except =>[:index] do
    resources :fields, :only => [:new]
  end
  resources :fields, :except => [:index, :new, :show]
end
