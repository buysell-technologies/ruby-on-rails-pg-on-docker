Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post 'signup', to: 'users#create'
  resources :users, only: [:show, :create]

  post 'login', to: 'sessions#create'
  # delete 'logout', to: 'sessions#destroy'
  
  resources :tasks do
    member do
      get :labels
      post 'relation_task_label', to: "relation_tasks_labels#create"
    end
  end

  resources :relation_task_label, only: [:create, :destroy]


end
