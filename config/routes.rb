Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  devise_for :teachers, controllers: { 
    sessions: 'teachers/sessions',
    registrations: 'teachers/registrations'
  }
end
