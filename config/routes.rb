Rails.application.routes.draw do
  root 'tasks#index'
  get 'tasks/search_title' => 'tasks#search_title'
  get 'tasks/search_status' => 'tasks#search_status'
  resources :tasks

end
