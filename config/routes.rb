Rails.application.routes.draw do
  root to: 'user/homes#top'
  namespace :user do
    resources :tasks, only: [:new, :create, :show, :edit, :update, :destroy]
    resources :users, only: [:show, :index, :update]
    resources :groups, only: [:new, :create, :index, :weekly, :calender, :show]
    resources :group_users, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
    resources :rooms, only: [:create, :show]
    resources :messages, only: [:create]
  end


#ユーザー登録を行えるのはadminのみにしたい。この場合は？今は誰でも可能の状態
  devise_for :admins, skip: [:passwords], controllers: {
  sessions: "admin/sessions",
  registrations: "admin/registrations"
}
  
  devise_for :users, skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}
  # devise_for :installs
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
