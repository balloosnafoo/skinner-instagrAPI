Rails.application.routes.draw do
  namespace :api, defaults: {format: :json} do
    resources :controllers, only: [:create, :show]
  end
end
