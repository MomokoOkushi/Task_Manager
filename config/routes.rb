Rails.application.routes.draw do

#ユーザー登録を行えるのはadminのみにしたい。この場合は？今は誰でも可能の状態
  devise_for :admin, skip: [:passwords], controllers: {
  sessions: "admin/sessions",
}

  devise_for :users, path: 'public', skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

  root to: 'public/homes#top'

  namespace :admin do
    get 'homes/top' => 'homes#top'
    resources :users, only: [:index, :show, :destroy]
    resources :groups, only: [:index, :show, :destroy] do
      resources :tasks, only: [:show, :destroy] do
        resources :comments, only: [:destroy]
      end
    end
  end

  namespace :public do
    get 'my_tasks' => 'tasks#my_tasks'
    get 'my_page' => 'users#show'
    resources :users, only: [:index, :update]
    resources :messages, only: [:create]
    get 'messages/:id' => 'messages#message', as: 'message'
    resources :groups, only: [:new, :create, :index, :show] do
      resources :group_users, only: [:create, :destroy]
      resources :tasks, only: [:new, :create, :show, :edit, :update, :destroy] do
        resources :comments, only: [:create, :destroy]
      end
    end
  end
end
