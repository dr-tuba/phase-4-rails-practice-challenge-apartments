Rails.application.routes.draw do
  resources :leases, only: [:create, :destroy]
  resources :tenants
  resources :apartments
 
end
