Rails.application.routes.draw do
  root 'tasks#index'
  get 'tasks/search' => 'tasks#search'
  resources :tasks

end
