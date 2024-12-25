Rails.application.routes.draw do
  devise_for :users

  resources :feeds do
    collection do
      post :search
    end
    resource :update, only: :update, module: :feeds
    resources :feed_subscriptions, only: %i[new create destroy]
  end

  resources :folders do
    resources :feeds, only: :show, module: :folders
    resource :toggle, only: :update, module: :folders
  end

  resources :items do
    collection do
      post :search
      post :change_view
    end
  end

  resources :user_items do
    resource :like, only: :update, module: :user_items
    resource :bookmark, only: :update, module: :user_items
  end

  get "/bookmarks", to: "bookmarks#index"

  authenticated :user, ->(u) { u.admin? } do
    namespace :admin do
      root to: "dashboard#show"
    end
  end

  authenticated :user do
    root to: "dashboard#show", as: :user_root
  end

  devise_scope :user do
    root to: "static#index"
  end
end
