Rails.application.routes.draw do
  devise_for :teachers

  namespace :api, defaults: { format: :json } do
    resources :questions, only: [:create]
  end
end
