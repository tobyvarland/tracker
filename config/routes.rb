Rails.application.routes.draw do

  resources :projections
  resources :entries do
    get "charts", on: :collection
  end
  root  "entries#index"
  get   "charts", to: "entries#charts"

end