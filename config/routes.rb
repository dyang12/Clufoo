WufooClone::Application.routes.draw do
  resource :session, :only => [:new, :create, :destroy]
  resources :users, :only => [:new, :create, :show]
  
  resources :forms, :except =>[:index] do
    resources :fields, :except => [:index, :show]
  end
  
  resource :entries, :except => [:new, :edit]
  
  get "forms/:id/display", :to => "forms#display", :as => "display_form"
  
  root :to => "sessions#new"
end
