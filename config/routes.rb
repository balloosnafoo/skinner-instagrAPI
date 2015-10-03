Rails.application.routes.draw do
  namespace :api, defaults: {format: :json} do
    resources :collections, only: [:create, :show]
  end
end
