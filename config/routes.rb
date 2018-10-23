Rails.application.routes.draw do
  scope "(:locale)", locale: /ja|en/ do
    devise_for :users
    root "static_pages#home"
    resources :motels do
      resources :reviews
    end
    resources :rooms
    resources :equipments
    resources :users, only: [:index, :show, :update]
    post "/like", to: "reviews#like"
  end
end
