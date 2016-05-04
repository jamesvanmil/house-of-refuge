Rails.application.routes.draw do
  root 'pages#home'
  resources :admissions, path: 'search-records'
  resources :gallery_images, only: [ :index, :show ], path: 'gallery-images'
  get 'home' => 'pages#home'
  get 'what-was-refuge' => 'pages#what_was_refuge'
  get 'about' => 'pages#about'
end
