Rails.application.routes.draw do
  root 'static_pages#home'

  resources :spend_budgets

  get 'spends/show'
  resources :spends

  get 'incomes/show'
  resources :incomes

  resources :transfers

  resources :monthly_closings

  get 'summaries/show'
  resources :summaries

  get 'wallet_summaries', to: 'wallet_summaries#index'
  get 'wallet_summaries/:walletId/:year/:month', to: 'wallet_summaries#show', as: 'wallet_summaries/show'
end
