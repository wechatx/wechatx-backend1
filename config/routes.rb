Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  scope :api do
    get 'users/index',to: 'users#index'
    get 'users/create',to: 'users#create'
    get 'users/update/:id',to: 'users#update'
    get 'users/delete/:id',to: 'users#delete'
    get 'users/destroy',to: 'users#destroy'
    get 'users/visit',to: 'users#visit'
  end
end
