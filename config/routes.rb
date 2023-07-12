Rails.application.routes.draw do
  namespace :api do
    post 'auth/login', to: "authentication#login"
    post 'auth/logout', to: "authentication#logout"

    get 'user/match_books', to: "user#match_books"
    get 'user/match_shows', to: "user#match_shows"
    get 'user/match_movies', to: "user#match_movies"
    post 'user/connect_to_book', to: "user#connect_to_book"
    post 'user/connect_to_show', to: "user#connect_to_show"
    post 'user/connect_to_movie', to: "user#connect_to_movie"
    get 'user/get_users_by_preferences/:user_id', to: "user#get_users_by_preferences"

    get 'preference', to: "preference#index"

    resources :user
    resources :book
    resources :movie
    resources :show
    resources :tag
  end

end
