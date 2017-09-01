Rails.application.routes.draw do
  get 'stats', to: 'stats#index'

  resources :videos, only: %w( show )
  resources :playlists, only: %w( show )
  resources :channels, only: %w( show new create index )

  get '/audio/:id.mp3', to: 'media#audio', as: :media 
  root 'channels#new'
end
