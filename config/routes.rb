Rails.application.routes.draw do

  resources :subjects , :admissions

  resources :sclasses
  
  root to: 'visitors#index'
  devise_for :users
  resources :users
  
end
