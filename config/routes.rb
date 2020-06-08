Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/forecast', to: 'forecast#show'
      get '/backgrounds', to: 'background_image#show'
      get '/foodie', to: 'foodie#show'
      post '/users', to: 'users#create'
      post '/sessions', to: 'sessions#create'
    end
  end
end
