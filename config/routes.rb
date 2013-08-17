MangoBravo::Application.routes.draw do
  root to: 'pages#index'

  post '/', to: 'pages#index'
end
