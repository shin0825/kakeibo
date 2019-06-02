Rails.application.routes.draw do
  get 'static_pages/home'

  root 'static_pages#home'
  get 'spends/show'
  get 'incomes/show'
  get 'summary/show'
  resources :incomes
  resources :spends
  resources :wallets
  resources :summary
end
