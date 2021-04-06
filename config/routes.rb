Rails.application.routes.draw do
  resource :users, only: [:create, :show]
  post "/login", to: "users#login"
  get "/auto_login", to: "users#auto_login"
end
