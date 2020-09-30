Rails.application.routes.draw do

  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      post '/orders/create', to: 'orders#create'
    end
  end

  apipie

  root 'apipie/apipies#index'

end
