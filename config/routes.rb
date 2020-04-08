Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post 'signup', to: 'users#create'
  resources :users, only: [:show, :create]

  post 'login', to: 'sessions#create'
  # delete 'logout', to: 'sessions#destroy'
  
  resources :tasks do
    member do
      get :labels
      post 'add_label', to: 'relation_task_labels#create'
      delete 'delete_label/:label_id', to: 'relation_task_labels#destroy'
    end
  end

  # このルートはいらないもしくは管理ユーザーに絞ったほうがいいかも
  resources :labels, only: [:show, :create, :update,:destroy]
end
