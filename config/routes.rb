Rails.application.routes.draw do
  devise_for :users

  devise_scope :user do
    root "devise/registrations#new"
  end
end
