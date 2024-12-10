Rails.application.routes.draw do
  devise_for :users

  resources :feeds do
    collection do
      post :search
    end
  end
  resources :folders

  authenticated :user do
    root to: "dashboard#show", as: :user_root
  end

  devise_scope :user do
    root "devise/registrations#new"
  end
end
