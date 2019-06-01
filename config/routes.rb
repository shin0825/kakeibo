Rails.application.routes.draw do
  resources :incomes
  resources :spends
  resources :wallets
  resources :summary
end
