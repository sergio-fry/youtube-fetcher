Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :channels, only: %w( show new create )

  get '/audio/:id.mp3', to: 'media#audio', as: :media 
  root 'channels#new'
end
