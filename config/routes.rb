Rails.application.routes.draw do
  root 'static_pages#home'
  get 'spends/show'
  get 'incomes/show'
  get 'summaries/show'
  get 'wallet_summaries/index'
  get 'wallet_summaries/:walletId/show/:year/:month', to: 'wallet_summaries#show', as: 'wallet_summaries/show'
  resources :incomes
  resources :spends
  resources :wallets
  resources :summaries
  resources :transfers
  resources :wallet_summaries
  resources :spend_budgets
  resources :monthly_closings
end
