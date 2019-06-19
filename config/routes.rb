Rails.application.routes.draw do
  devise_for :teachers, controllers: { sessions: 'sessions' }
end
