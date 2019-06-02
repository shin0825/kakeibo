Rails.application.routes.draw do
  root 'static_pages#home'
  get 'spends/show'
  get 'incomes/show'
  get 'summary/show'
  resources :incomes
  resources :spends
  resources :wallets
  resources :summary
end
