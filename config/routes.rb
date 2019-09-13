Rails.application.routes.draw do
  resources :feedbacks do
    collection do
      get 'thank_you', action: :thank_you
    end

  end

  get 'about', to: 'pages#about'

  get 'search/index'

  get 'stats', to: 'stats#index'

  resources :videos, only: %w( show index )
  resources :playlists, only: %w( show )
  resources :channels, only: %w( show new create index )

  get '/audio/:id.m4a', to: 'media#audio', as: :media 
  get '/audio/:id.mp3', to: 'media#audio'
  root 'channels#new'

  get 'search', to: 'search#index'
end
