Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'home#index'
  resources :tracks
  resources :lessons
  get '/signup' => 'users#new'
  post '/users' => 'users#create'
  get '/account/:id' => 'users#show', :as => :user
  get '/account/:id/edit' => 'users#edit', :as => :edit_user
  patch '/account/:id' => 'users#patch'

  get '/signin' => 'sessions#new'
  post '/signin' => 'sessions#create'
  get '/signout' => 'sessions#destroy'

end
