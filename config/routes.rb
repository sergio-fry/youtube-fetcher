Rails.application.routes.draw do
  get 'about', to: 'pages#about'

  get 'search/index'

  get 'stats', to: 'stats#index'

  resources :videos, only: %w( show index )
  resources :playlists, only: %w( show )
  resources :channels, only: %w( show new create index )

  get '/audio/:id.mp3', to: 'media#audio', as: :media 
  root 'channels#new'

  get 'search', to: 'search#index'
end
