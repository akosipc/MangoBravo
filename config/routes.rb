MangoBravo::Application.routes.draw do
  root to: 'pages#index'

  get '/stories', to: 'pages#stories', as: :stories
  post '/auth', to: 'pages#auth', as: :auth
  get '/convert/:id', to: 'pages#convert', as: :convert
  delete '/clear', to: 'pages#clear', as: :clear
  get '/documentation', to: 'pages#documentation', as: :documentation
end
