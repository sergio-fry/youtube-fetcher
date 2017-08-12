Rails.application.routes.draw do
  resources :playlists, only: %w( show )
  resources :channels, only: %w( show new create index )

  get '/audio/:id.mp3', to: 'media#audio', as: :media 
  root 'channels#new'
end
