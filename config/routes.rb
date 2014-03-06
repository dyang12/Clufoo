WufooClone::Application.routes.draw do
  root :to => "static_pages#root"
  
  resource :session, :only => [:new, :create, :destroy]
  resources :users, :except => [:index]
  resources :accounts, :only => [:new, :create, :show] do
    resources :users, :only => [:index]
  end
  
  resources :forms do
    resources :fields, :except => [:index, :show]
    resources :entries, :only => [:index, :new]
  end
  
  resources :entries, :except => [:new, :index]

  post "forms/:id/duplicate", :to => "forms#duplicate", :as => "duplicate_form"
  put "users/:id/toggle", :to=> "users#toggle_admin", :as => "toggle_user"
  get "help", :to => "static_pages#help"
end
