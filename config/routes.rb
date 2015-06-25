Rails.application.routes.draw do
  devise_for :users
  resources :stories do
    member do
      get "like", to: "stories#upvote"
      get "dislike", to: "stories#downvote"
    end
    resources :comments
  end

  root "stories#index"
end
