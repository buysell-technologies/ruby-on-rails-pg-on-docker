Rails.application.routes.draw do
  get 'relation_task_label/create'
  get 'relation_task_label/destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post 'signup', to: 'users#create'
  resources :users, only: [:show, :create]

  post 'login', to: 'sessions#create'
  # delete 'logout', to: 'sessions#destroy'
  
  resources :tasks do
    member do
      get :labels
    end
  end

  resources :relation_task_label, only: [:create, :destroy]

end
