Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #トップページはタスク一覧
  root to: 'tasks#index'
  
  resources :tasks
end
