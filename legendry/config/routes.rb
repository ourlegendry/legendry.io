Rails.application.routes.draw do
  get 'welcome/index'
  devise_for :users
  root 'welcome#index'
  resources :organizations do
    resources :specifications do
      resources :entries do
        member do
          post 'commit'
        end
      end
    end
  end
end
