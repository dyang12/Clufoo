WufooClone::Application.routes.draw do
  resource :session, :only => [:new, :create, :destroy]
  resources :users, :except => [:index]
  resources :accounts, :only => [:new, :create, :show] do
    resources :users, :only => [:index]
  end
  
  resources :forms do
    resources :fields, :except => [:index, :show]
    resources :entries, :only => [:index, :new, :edit]
  end
  
  resources :entries, :except => [:new, :edit, :index]

  post "forms/:id/duplicate", :to => "forms#duplicate", :as => "duplicate_form"
  put "users/:id/toggle", :to=> "users#toggle_admin", :as => "toggle_user"
  root :to => "sessions#new"
end
