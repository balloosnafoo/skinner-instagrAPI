Rails.application.routes.draw do
  root :to => "static_pages#home"

  namespace :api, defaults: {format: :json} do
    resources :collections, only: [:create, :show]
  end
end
