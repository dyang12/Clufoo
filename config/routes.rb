WufooClone::Application.routes.draw do
  resource :session, :only => [:new, :create, :destroy]
  resources :users, :only => [:new, :create, :show]
  
  resources :forms, :except =>[:index] do
    resources :fields, :except => [:index, :show]
    resources :entries, :only => [:index]
  end
  
  resources :entries, :except => [:new, :edit, :index]
  
  get "forms/:id/display", :to => "forms#display", :as => "display_form"
  
  root :to => "sessions#new"
end
