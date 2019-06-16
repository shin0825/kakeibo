Rails.application.routes.draw do
  root 'static_pages#home'
  get 'spends/show'
  get 'incomes/show'
  get 'summary/show'
  get 'wallet_summary/show'
  get 'wallet_summary/detail'
  resources :incomes
  resources :spends
  resources :wallets
  resources :summary
  resources :transfers
  resources :wallet_summary
  resources :spend_budgets
  resources :monthly_closings
end
