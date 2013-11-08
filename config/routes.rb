WufooClone::Application.routes.draw do
  resource :session, :only => [:new, :create, :destroy]
  resources :users, :only => [:new, :create, :show]
  resources :account, :only => [:new, :create, :show]
  
  resources :forms do
    resources :fields, :except => [:index, :show]
    resources :entries, :only => [:index, :new, :edit]
  end
  
  resources :entries, :except => [:new, :edit, :index]

  post "forms/:id/duplicate", :to => "forms#duplicate", :as => "duplicate_form"
  root :to => "sessions#new"
end
