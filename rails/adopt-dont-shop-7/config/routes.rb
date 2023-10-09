Rails.application.routes.draw do
  # get "/", to: "application#welcome"
  root "application#welcome"

  resources :applications, only:[:show, :new, :create]
  resources :shelters, only:[:index, :new, :show, :create, :edit, :update, :destroy]
  resources :pets, only:[:index, :show, :edit, :update, :destroy]
  resources :veterinary_offices, only:[:index, :new, :show, :create, :edit, :update, :destroy]
  resources :veterinarians, only:[:index, :show, :edit, :update, :destroy]

  get "/shelters/:shelter_id/pets", to: "shelters#pets"
  get "/shelters/:shelter_id/pets/new", to: "pets#new"
  post "/shelters/:shelter_id/pets", to: "pets#create"

  get "/veterinary_offices/:veterinary_office_id/veterinarians", to: "veterinary_offices#veterinarians"
  get "/veterinary_offices/:veterinary_office_id/veterinarians/new", to: "veterinarians#new"
  post "/veterinary_offices/:veterinary_office_id/veterinarians", to: "veterinarians#create"

  namespace :admin do
    resources :applications, only:[:show, :update]
  end
end
