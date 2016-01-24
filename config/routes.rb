Rails.application.routes.draw do
  get '/users/sign_in/:id', to: 'users#sign_in'
  resources :users, :only => [:show, :edit]
  resources :schedules, :only => [:index, :show]
  resources :schedule_users, :only => [:create, :update]

  namespace :admin do
    resources :users
    resources :schedules
    resources :roles
  end
end
