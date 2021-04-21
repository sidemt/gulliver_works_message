# frozen_string_literal: true
Rails.application.routes.draw do
  namespace :auth do
    namespace :v1 do
      post :sign_in, to: 'auth#sign_in'
      post :sign_up, to: 'auth#sign_up'
    end
  end

  namespace :enterprise_auth do
    namespace :v1 do
      post :sign_in, to: 'auth#sign_in'
      post :sign_up, to: 'auth#sign_up'
    end
  end

  namespace :v1 do
    resources :accounts, only: %i[index show destroy] do
      resources :rooms, only: %i[index create]
    end
    resources :occupation_main_categories, only: :index
    resources :industry_categories, only: :index
    resources :prefectures, only: :index
    resources :employment_statuses, only: :index
    resources :rooms, only: :show
  end

  namespace :enterprise do
    namespace :v1 do
      resources :employees, only: %i[show destroy]
      resources :companies do
        resources :rooms, only: %i[index create]
      end
      resources :occupation_main_categories, only: :index
      resources :industry_categories, only: :index
      resources :prefectures, only: :index
      resources :employment_statuses, only: :index
      resources :rooms, only: :show
    end
  end
end
