Rails.application.routes.draw do
  devise_for :users

  resources :feeds
  resources :folders

  authenticated :user do
    root to: "dashboard#show", as: :user_root
  end

  devise_scope :user do
    root "devise/registrations#new"
  end
end
