Rails.application.routes.draw do
  root 'static_pages#home'

  get 'spend_budgets/monthly/:year/:month', to: 'spend_budgets#index', as: 'spend_budgets/index'
  resources :spend_budgets

  get 'spends/:year/:month', to: 'spends#index', as: 'spends/index'
  resources :spends

  get 'incomes/:year/:month', to: 'incomes#index', as: 'incomes/index'
  resources :incomes

  resources :transfers

  resources :monthly_closings

  get 'summaries/:year/:month', to: 'summaries#index', as: 'summaries/index'
  resources :summaries

  get 'wallet_summaries', to: 'wallet_summaries#index'
  get 'wallet_summaries/:walletId/:year/:month', to: 'wallet_summaries#show', as: 'wallet_summaries/show'

  post '/callback', to: 'linebot#callback'
end
