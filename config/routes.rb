Rails.application.routes.draw do
  get 'spends/show'
  get 'incomes/show'
  get 'summary/show'
  resources :incomes
  resources :spends
  resources :wallets
  resources :summary
end
