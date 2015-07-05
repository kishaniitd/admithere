Rails.application.routes.draw do

  resources :subjects , :admissions

  resources :sclasses
  
  root to: 'visitors#index'
  devise_for :users
  resources :users
  
  resources :admissions do
    get :autocomplete_user_name, :on => :collection
  end
  
  
end
